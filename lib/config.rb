require 'singleton'
class Config
  attr_reader :config
  include Singleton

  def initialize
    @file = 'config.yml'
    @config = {}
  end

  # def read(*options)
  #   load_from_yaml.dig options.join ','
  # end

  def load_from_yaml
    @config = YAML.load_file @file if @config.empty?
  end
end
