/** \file mapping.h
 * \brief Mapping visualization header file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-02-14
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

#ifndef GRL_MAPPING_VISUALIZATION_H_
#define GRL_MAPPING_VISUALIZATION_H_

#include <string.h>
#include <pthread.h>

#include <grl/mapping.h>
#include <grl/visualizations/field.h>

namespace grl
{

/// Mapping visualization.
class MappingVisualization : public FieldVisualization
{
  public:
    TYPEINFO("visualization/field/mapping", "Visualizes a mapping over a field of states")

  protected:
    Mapping *mapping_;
    size_t dim_;
  
  public:
    MappingVisualization() : mapping_(NULL), dim_(0) { }
    ~MappingVisualization()
    {
      stopAndJoin();
    }
    
    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);
  
    // From FieldVisualization
    virtual double value(const Vector &in) const;
};

}

#endif /* GRL_MAPPING_VISUALIZATION_H_ */
