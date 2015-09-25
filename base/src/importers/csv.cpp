/** \file csv.cpp
 * \brief Comma separated values importer source file.
 *
 * \author    Wouter Caarls <wouter@caarls.org>
 * \date      2015-09-25
 *
 * \copyright \verbatim
 * Copyright (c) 2015, Wouter Caarls and Ivan Koryakovskiy
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

#include <sys/stat.h>
#include <grl/importer.h>

using namespace grl;

REGISTER_CONFIGURABLE(CSVImporter)

void CSVImporter::request(ConfigurationRequest *config)
{
  config->push_back(CRP("file", "Input base filename", file_));
}

void CSVImporter::configure(Configuration &config)
{
  file_ = config["file"].str();
  if (file_.empty())
    throw bad_param("exporter/csv:file");
}

void CSVImporter::reconfigure(const Configuration &config)
{
}

void CSVImporter::init(const std::initializer_list<std::string> &headers)
{
  headers_ = headers;
}

void CSVImporter::open(const std::string &variant)
{
  stream_.open((file_+variant+".csv").c_str());
  
  std::string line;
  std::getline(stream_, line);
  if (line != "COLUMNS:")
  {
    ERROR("CSV file should start with COLUMNS directive");
    throw bad_param("importer/csv:file");
  }
  
  std::vector<bool> found(false, headers_.size());
  do
  {
    std::getline(stream_, line);
    
    if (line != "DATA:")
    {
      line.erase(0, line.find_first_not_of(" \t"));
      line.erase(line.find_last_not_of(" \t,")+1);
      if (line.find('[') != std::string::npos)
        line.erase(line.find('['));
      
      for (size_t ii=0; ii != headers_.size(); ++ii)
        if (headers_[ii] == line)
        {
          order_.push_back(ii);
          found[ii] = true;
        }
    }
  } while (stream_.good() && line != "DATA:");
  
  for (size_t ii=0; ii != headers_.size(); ++ii)
    if (!found[ii])
    {
      ERROR("CSV file does not contain required field '" << headers_[ii] << "'");
      throw bad_param("importer/csv:file");
    }
}

bool CSVImporter::read(const std::initializer_list<Vector*> &vars)
{
  if (vars.size() != headers_.size())
  {
    ERROR("Variable list does not match header list");
    return false;
  }

  std::vector<Vector*> var_vec;
  var_vec.insert(var_vec.end(), vars.begin(), vars.end());
  for (size_t ii=0; ii != headers_.size(); ++ii)
    var_vec[ii]->clear();

  if (!stream_.good())
    return false;

  for (size_t ii=0; ii < order_.size() && stream_.good(); ++ii)
  {
    double v;
    stream_ >> v;
    var_vec[order_[ii]]->push_back(v);
    
    char c;
    while ((c = stream_.get()) == ',' || c == ' ' || c == '\t');
    if (c != '\n') stream_.putback(c);
  }
  
  return stream_.good();
}