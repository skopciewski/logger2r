# encoding: utf-8

# Copyright (C) 2017 Szymon Kopciewski
#
# This file is part of Logger2r.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "logger2r/version"
require "logger"

module Logger2r
  def self.for_class_with_level(class_name, severity_level)
    logger = ::Logger.new(STDOUT)
    logger.progname = class_name
    logger.level = severity_level
    logger
  end
end
