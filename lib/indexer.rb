require_relative 'topic'
require 'yaml'

module Indexer
  def self.write_index_in(to_file, from_topics)
    index = generate_index(from_topics).to_yaml
    File.write to_file, index
  end

  def self.generate_index(topics)
    h = {}
    topics.each do |t|
      h.merge!(t.id.to_s => t.filename)
    end
    h
  end
end
