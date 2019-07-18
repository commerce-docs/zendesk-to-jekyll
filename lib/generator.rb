# frozen_string_literal: true

require_relative 'topic'
require 'yaml'

module Generator

  FILENAME_PATTERN = %r{.+/\d+-([^/]+)\.json}.freeze

  def self.articles(from_file)
    YAML.load_file(from_file)['results']
  end

  def self.generate_topics(from_file)
    articles(from_file).map do |article|
      Topic.new do |t|
        t.id = article['id']
        t.filename = url_to_filename article['url']
        t.title = article['title']
        t.group = article['section_id']
        t.labels = article['label_names']
        t.html_content = article['body']
      end
    end
  end
end

private

def url_to_filename(url)
  url.scan(Generator::FILENAME_PATTERN).
     join.
     downcase.
     gsub(' ', '-').
     concat('.md')
end
