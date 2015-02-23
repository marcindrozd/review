require 'active_support/ordered_options'

pub_config = ActiveSupport::OrderedOptions.new
pub_config.deep_merge!(YAML.load(ERB.new(File.read(File.expand_path('../config.yml', __FILE__))).result)[Rails.env])
sec_config = YAML.load(ERB.new(File.read(File.expand_path('../sec_config.yml', __FILE__))).result)[Rails.env] rescue {}

AppConfig = pub_config.deep_merge(sec_config).freeze
