require 'yaml'
require 'kramdown'

module Converter
  DEFAULT_OPTIONS = {
    html_to_native: true,
    line_width: 1000,
    input: 'html'
  }

  def self.kramdownify(string, options = {})
    document = Kramdown::Document.new(string, DEFAULT_OPTIONS.merge(options))
    document.to_kramdown
  end
end

@topics = []
Topic = Struct.new(:id, :filename, :title, :group, :labels, :html_content, :kramdown_content)
OUTPUT_DIR = 'output'

def file
  ARGV[0] || raise('Provide a JSON file with content from Zendesk. For example, ruby zendesk-to-kramdown.rb how-to.json')
end

def articles
  @articles = YAML.load_file(file)['results']
end

def generate_topics
  articles.each do |article|
    topic = Topic.new
    topic.id = article['id']
    topic.filename = article['name'].downcase.gsub(' ', '-').concat('.md')
    topic.title = article['title']
    topic.group = article['section_id']
    topic.labels = article['label_names']
    topic.html_content = article['body']
    topic.kramdown_content = convert_html(article['body'])
    @topics << topic
  end
end

def convert_html(content)
  Converter.kramdownify(content)
end

def topics
  generate_topics if @topics.empty?
  @topics
end

def write_topics
  Dir.mkdir(OUTPUT_DIR) unless Dir.exist?(OUTPUT_DIR)
  topics.each do |topic|
    string = %Q(
---
title: #{topic.title}
group: #{topic.group}
---

#{topic.kramdown_content}
    ).strip

    File.write("output/#{topic.filename}", string)
  end
end

write_topics