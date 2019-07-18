require_relative 'topic'
require 'yaml'

module Indexer
  def self.generate_index_for_topics
    h = {}
    topics = Topic.all
    topics.each do |t|
      h.merge!(t.id.to_s => t.filename)
    end
    h
  end

  def self.write_index_in(to_file)
    index = generate_index_for_topics.to_yaml
    File.write to_file, index
  end
end
