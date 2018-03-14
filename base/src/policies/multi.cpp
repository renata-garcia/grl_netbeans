/** \file multi.cpp
 * \brief Combining policy source file. 
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2018-03-13
 *
 * \copyright \verbatim
 * Copyright (c) 2018, Wouter Caarls
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

#include <grl/policies/multi.h>

using namespace grl;

REGISTER_CONFIGURABLE(MultiPolicy)

void MultiPolicy::request(ConfigurationRequest *config)
{
  config->push_back(CRP("strategy", "Combination strategy", strategy_str_, CRP::Configuration, {"add_probabilities"}));
  config->push_back(CRP("discretizer", "discretizer.action", "Action discretizer", discretizer_));
  config->push_back(CRP("policy", "mapping/policy", "Sub-policies", &policy_));
}

void MultiPolicy::configure(Configuration &config)
{
  strategy_str_ = config["strategy"].str();
  if (strategy_str_ == "add_probabilities")
    strategy_ = csAddProbabilities;
  else
    throw bad_param("mapping/policy/multi:strategy");

  discretizer_ = (Discretizer*)config["discretizer"].ptr();
  
  policy_ = *(ConfigurableList*)config["policy"].ptr();
  
  if (policy_.empty())
    throw bad_param("mapping/policy/multi:policy");
}

void MultiPolicy::reconfigure(const Configuration &config)
{
}

void MultiPolicy::act(const Observation &in, Action *out) const
{
  LargeVector dist;
  distribution(in, *out, &dist);
  size_t action = sample(dist);

  std::vector<Vector> variants;
  discretizer_->options(in, &variants);
  if (action >= variants.size())
  {
    ERROR("Subpolicy action out of bounds: " << action << " >= " << variants.size());
    throw bad_param("mapping/policy/multi:policy");
  }

  *out = variants[action];
  
  // Actually, this may be different per policy. Just to be on the safe side,
  // we always cut off all off-policy traces.
  out->type = atExploratory;
}

void MultiPolicy::act(double time, const Observation &in, Action *out)
{
  // Call downstream policies to update time
  for (size_t ii=0; ii != policy_.size(); ++ii)
  {
    Action temp = *out;
    policy_[ii]->act(time, in, &temp);
  }
    
  // Then continue with usual action selection
  act(in, out);
}

void MultiPolicy::distribution(const Observation &in, const Action &prev, LargeVector *out) const
{
  LargeVector dist;
  
  // Get first policy probabilities
  policy_[0]->distribution(in, prev, out);
  
  for (size_t ii=1; ii != policy_.size(); ++ii)
  {
    // Add subsequent policies' probabilities according to chosen strategy
    policy_[ii]->distribution(in, prev, &dist);
    if (dist.size() != out->size())
    {
      ERROR("Subpolicy " << ii << " has incompatible number of actions");
      throw bad_param("mapping/policy/multi:policy");
    }
    
    for (size_t jj=0; jj < dist.size(); ++jj)
    {
      switch (strategy_)
      {
        case csAddProbabilities:
          (*out)[jj] += dist[jj];
      }
    }
  }
}
