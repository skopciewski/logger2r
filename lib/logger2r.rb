# encoding: utf-8
# frozen_string_literal: true

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
require "yaml"

module Logger2r
  DEFAULT_CONFIG = {
    severity_level: :error,
    device: nil,
    progname: nil,
    datetime_format: nil,
    formatter_class: nil
  }.freeze

  class << self
    attr_writer :config_file

    def for_class(class_name)
      config = get_config_for_class(class_name)
      create_logger_for_config(config)
    end

    private

    def config_from_file?
      defined?(@config_file) && !@config_file.nil?
    end

    def get_config_for_class(class_name)
      config_form_file = config_from_file? ? YAML.load_file(@config_file) : {}
      config_form_file = config_form_file.fetch(:logger2r_config, {})
      config_for_all_classes = config_form_file.fetch(:default, {})
      config_for_class = config_form_file.fetch(class_name.to_sym, {})
      computed_config_from_file = config_for_all_classes.merge(config_for_class)
      DEFAULT_CONFIG.merge(computed_config_from_file).merge(progname: class_name)
    end

    def create_logger_for_config(config)
      logger = ::Logger.new parse_device(config.fetch(:device))
      logger.progname = config.fetch(:progname)
      logger.level = config.fetch(:severity_level)
      logger.datetime_format = config.fetch(:datetime_format)
      logger.formatter = parse_formatter(config.fetch(:formatter_class), logger.datetime_format)
      logger
    end

    def parse_device(device_name)
      normalized_name = device_name.to_s.downcase
      return STDOUT if normalized_name == "stdout"
      return STDERR if normalized_name == "stderr"
      begin
        dev_obj = Object.const_get device_name
        return dev_obj.new
      rescue
        device_name
      end
    end

    def parse_formatter(formatter_class, datetime_format)
      return nil unless formatter_class
      formatter_obj = Object.const_get formatter_class
      formatter_obj.new.tap { |f| f.datetime_format = datetime_format }
    end
  end
end
