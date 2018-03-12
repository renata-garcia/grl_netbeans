/** \file bounded_q.cpp
 * \brief Bounded Q policy source file. 
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-11
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

#include <grl/policies/bounded_q.h>

using namespace grl;

REGISTER_CONFIGURABLE(BoundedQPolicy)

void BoundedQPolicy::request(ConfigurationRequest *config)
{
  std::cout << "rgo BoundedQPolicy::request(ConfigurationRequest *config):" << std::endl;
  config->push_back(CRP("bound", "Maximum action delta", bound_));
  QPolicy::request(config);
}

void BoundedQPolicy::configure(Configuration &config)
{
  std::cout << "rgo BoundedQPolicy::configure(Configuration &config):" << std::endl;
  QPolicy::configure(config);
  
  bound_ = config["bound"].v();
}

void BoundedQPolicy::reconfigure(const Configuration &config)
{
  std::cout << "rgo BoundedQPolicy::reconfigure(const Configuration &config):" << std::endl;
}

void BoundedQPolicy::act(double time, const Observation &in, Action *out)
{
  std::cout << "rgo BoundedQPolicy::act(double time, const Observation &in, Action *out):" << std::endl;
  if (out->size())
  {
    LargeVector qvalues, filtered;
    ActionType at;
    std::vector<size_t> idx;
    
    values(in, &qvalues);
    filter(in, *out, qvalues, &filtered, &idx);
    
    size_t action = sampler_->sample(time, filtered, &at);
    *out = discretizer_->at(in, idx[action]);
    out->type = at;
  }
  else
    QPolicy::act(in, out);
}

void BoundedQPolicy::distribution(const Observation &in, const Action &prev, LargeVector *out) const
{
  std::cout << "rgo BoundedQPolicy::distribution(const Observation &in, const Action &prev, LargeVector *out) const:" << std::endl;
  if (prev.size())
  {
    LargeVector qvalues, filtered, dist;
    std::vector<size_t> idx;
  
    values(in, &qvalues);
    filter(in, prev, qvalues, &filtered, &idx);

    sampler_->distribution(filtered, &dist);
    
    *out = ConstantVector(qvalues.size(), 0.);
    for (size_t ii=0; ii != filtered.size(); ++ii)
      (*out)[idx[ii]] = dist[ii];
  }
  else
    QPolicy::distribution(in, prev, out);
}

/**
 * Returns both the Q values of the valid actions, and
 * an index array such that filtered[ii] = qvalues[idx[ii]]
 */
void BoundedQPolicy::filter(const Vector &in, const Vector &prev_out, const LargeVector &qvalues, LargeVector *filtered, std::vector<size_t> *idx) const
{
  std::cout << "rgo BoundedQPolicy::filter(const Vector &in, const Vector &prev_out, const LargeVector &qvalues, LargeVector *filtered, std::vector<size_t> *idx) const:" << std::endl;
  if (prev_out.size() != bound_.size())
    throw bad_param("mapping/policy/value/q/bounded:bound");
    
  idx->clear();
  idx->reserve(qvalues.size());
  
  size_t aa=0;
  for (Discretizer::iterator it = discretizer_->begin(in); it != discretizer_->end(); ++it, ++aa)
  {
    Vector action = *it;
    bool valid=true;
    for (size_t ii=0; ii < prev_out.size(); ++ii)
    {
      if (fabs(action[ii] - prev_out[ii]) > bound_[ii])
      {
        valid=false;
        break;
      }
    }
    
    if (valid)
      idx->push_back(aa);
  }
  
  filtered->resize(idx->size());
  for (size_t ii=0; ii < idx->size(); ++ii)
    (*filtered)[ii] = qvalues[(*idx)[ii]];
}
