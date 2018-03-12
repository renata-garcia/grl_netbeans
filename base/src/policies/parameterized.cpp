/** \file parameterized.cpp
 * \brief Parameterized action policy source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-13
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

#include <grl/policies/parameterized.h>

using namespace grl;

REGISTER_CONFIGURABLE(ParameterizedActionPolicy)

void ParameterizedActionPolicy::request(ConfigurationRequest *config)
{
  std::cout << "rgo ParameterizedActionPolicy::request(ConfigurationRequest *config):" << std::endl;
  config->push_back(CRP("sigma", "Standard deviation of exploration distribution", sigma_, CRP::Configuration));

  config->push_back(CRP("output_min", "vector.action_min", "Lower limit on outputs", min_, CRP::System));
  config->push_back(CRP("output_max", "vector.action_max", "Upper limit on outputs", max_, CRP::System));

  config->push_back(CRP("projector", "projector.observation", "Projects observations onto representation space", projector_));
  config->push_back(CRP("representation", "representation/parameterized.action", "Action representation", representation_));
}

void ParameterizedActionPolicy::configure(Configuration &config)
{
  std::cout << "rgo ParameterizedActionPolicy::configure(Configuration &config):" << std::endl;
  projector_ = (Projector*)config["projector"].ptr();
  representation_ = (ParameterizedRepresentation*)config["representation"].ptr();
  
  sigma_ = config["sigma"].v();
  min_ = config["output_min"].v();
  max_ = config["output_max"].v();
  
  if (min_.size() != max_.size() || !min_.size())
    throw bad_param("policy/action:{output_min,output_max}");
  
  if (!sigma_.size())
    sigma_ = ConstantVector(min_.size(), 0.);
}

void ParameterizedActionPolicy::reconfigure(const Configuration &config)
{
  std::cout << "rgo ParameterizedActionPolicy::reconfigure(const Configuration &config):" << std::endl;
}

void ParameterizedActionPolicy::act(const Observation &in, Action *out) const
{
  std::cout << "rgo ParameterizedActionPolicy::act(const Observation &in, Action *out) const:" << std::endl;
  ProjectionPtr p = projector_->project(in);
  representation_->read(p, &out->v);
  out->type = atGreedy;
  
  // Some representations may not always return a value.
  if (!out->size())
    *out = (min_+max_)/2;
  
  for (size_t ii=0; ii < out->size(); ++ii)
  {
    if (sigma_[ii])
    {
      (*out)[ii] += RandGen::getNormal(0., sigma_[ii]);
      out->type = atExploratory;
    }
      
    (*out)[ii] = fmin(fmax((*out)[ii], min_[ii]), max_[ii]);
  }
}
