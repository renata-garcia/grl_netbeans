/** \file action.cpp
 * \brief Action and action-probability policies policies source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-16
 *
 * \copyright \verbatim
 * Copyright (c) 2015, Wouter Caarls
 * All rights reserved.
 *
 * This file is part of GRL, the Generic Reinforcement Learning library.
 *
 * GRL is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * \endverbatim
 */

#include <grl/policies/action.h>

using namespace grl;

REGISTER_CONFIGURABLE(ActionPolicy)
REGISTER_CONFIGURABLE(ActionProbabilityPolicy)

void ActionPolicy::request(ConfigurationRequest *config)
{
  std::cout << "rgo ActionPolicy::request(ConfigurationRequest *config):" << std::endl;
  config->push_back(CRP("sigma", "Standard deviation of exploration distribution", sigma_, CRP::Configuration));
  config->push_back(CRP("decay_rate", "Multiplicative decay factor per episode", decay_rate_, CRP::Configuration));
  config->push_back(CRP("decay_min", "Minimum decay (sigma_min = sigma*decay_min)", decay_min_, CRP::Configuration));
  
  config->push_back(CRP("output_min", "vector.action_min", "Lower limit on outputs", min_, CRP::System));
  config->push_back(CRP("output_max", "vector.action_max", "Upper limit on outputs", max_, CRP::System));

  config->push_back(CRP("projector", "projector.observation", "Projects observations onto representation space", projector_));
  config->push_back(CRP("representation", "representation.action", "Action representation", representation_));
}

void ActionPolicy::configure(Configuration &config)
{
  std::cout << "rgo ActionPolicy::configure(Configuration &config):" << std::endl;
  projector_ = (Projector*)config["projector"].ptr();
  representation_ = (Representation*)config["representation"].ptr();
  
  sigma_ = config["sigma"].v();
  decay_rate_ = config["decay_rate"];
  decay_min_ = config["decay_min"];
  decay_ = 1.;
  min_ = config["output_min"].v();
  max_ = config["output_max"].v();
  
  if (min_.size() != max_.size() || !min_.size())
    throw bad_param("policy/action:{output_min,output_max}");
  
  if (!sigma_.size())
    sigma_ = VectorConstructor(0.);
    
  if (sigma_.size() == 1)
    sigma_ = ConstantVector(min_.size(), sigma_[0]);
    
  if (sigma_.size() != min_.size())
    throw bad_param("policy/action:sigma");
}

void ActionPolicy::reconfigure(const Configuration &config)
{
  std::cout << "rgo ActionPolicy::reconfigure(const Configuration &config)" << std::endl;
  if (config.has("action") && config["action"].str() == "reset")
    decay_ = 1;
}

void ActionPolicy::act(double time, const Observation &in, Action *out)
{
  std::cout << "rgo ActionPolicy::act(double time, const Observation &in, Action *out)" << std::endl;
  if (time == 0.)
    decay_ = fmax(decay_*decay_rate_, decay_min_);
  return act(in, out);
}

void ActionPolicy::act(const Observation &in, Action *out) const
{
  std::cout << "rgo ActionPolicy::act(const Observation &in, Action *out) const" << std::endl;
  ProjectionPtr p = projector_->project(in);
  representation_->read(p, &out->v);
  out->type = atGreedy;
  
  // Some representations may not always return a value.
  if (!out->size())
    *out = (min_+max_)/2;
  
  if (sigma_.size() != out->size())
    throw bad_param("policy/action:{output_min,output_max}");
  
  for (size_t ii=0; ii < out->size(); ++ii)
  {
    if (sigma_[ii])
    {
      (*out)[ii] += RandGen::getNormal(0., sigma_[ii]*decay_);
      out->type = atExploratory;
    }
      
    (*out)[ii] = fmin(fmax((*out)[ii], min_[ii]), max_[ii]);
  }
}

void ActionProbabilityPolicy::request(ConfigurationRequest *config)
{
  std::cout << "rgo ActionProbabilityPolicy::request(ConfigurationRequest *config):" << std::endl;
  config->push_back(CRP("discretizer", "discretizer", "Action discretizer", discretizer_));
  config->push_back(CRP("projector", "projector.pair", "Projects observation-action pairs onto representation space", projector_));
  config->push_back(CRP("representation", "representation.value/action", "Action-probability representation", representation_));
}

void ActionProbabilityPolicy::configure(Configuration &config)
{
  std::cout << "rgo ActionProbabilityPolicy::configure(Configuration &config):" << std::endl;
  discretizer_ = (Discretizer*)config["discretizer"].ptr();
  
  projector_ = (Projector*)config["projector"].ptr();
  representation_ = (Representation*)config["representation"].ptr();
}

void ActionProbabilityPolicy::reconfigure(const Configuration &config)
{
  std::cout << "rgo ActionProbabilityPolicy::reconfigure(const Configuration &config):" << std::endl;
}

void ActionProbabilityPolicy::act(const Observation &in, Action *out) const
{
  std::cout << "rgo ActionProbabilityPolicy::act(const Observation &in, Action *out) const:" << std::endl;
  std::vector<Vector> variants;
  std::vector<ProjectionPtr> projections;
  
  discretizer_->options(in, &variants);
  projector_->project(in, variants, &projections);

  Vector dist(variants.size()), v;
  
  for (size_t ii=0; ii < variants.size(); ++ii)
    dist[ii] = representation_->read(projections[ii], &v);
    
  *out = variants[sample(dist)];
  out->type = atExploratory;
}

void ActionProbabilityPolicy::distribution(const Observation &in, const Action &prev, LargeVector *out) const
{
  std::cout << "rgo ActionProbabilityPolicy::distribution(const Observation &in, const Action &prev, LargeVector *out) const:" << std::endl;
  std::vector<Vector> variants;
  std::vector<ProjectionPtr> projections;
  
  discretizer_->options(in, &variants);
  projector_->project(in, variants, &projections);

  out->resize(variants.size());

  Vector v;
  double total=0.;
  
  for (size_t ii=0; ii < variants.size(); ++ii)
   total += (*out)[ii] = representation_->read(projections[ii], &v);
   
  (*out) /= total;
}
