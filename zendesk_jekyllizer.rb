# frozen_string_literal: true

require 'yaml'
require_relative 'topic'
require_relative 'imaginizer'
require_relative 'urlizer'

@topics = []
OUTPUT_DIR = 'output'
IMAGE_DIR = 'images'
FULL_IMAGE_DIR = File.join(OUTPUT_DIR, IMAGE_DIR)
FILENAME_PATTERN = %r{.+/\d+-([^/]+)\.json}.freeze
FILES_TO_READ_PATTERN = File.join OUTPUT_DIR, '**', '*.md'

def file
  ARGV[0] || raise('Provide a JSON file with content from Zendesk. For example, ruby zendesk-to-kramdown.rb how-to.json')
end

def articles
  @articles = YAML.load_file(file)['results']
end

def generate_topics
  articles.each do |article|
    @topics << Topic.new do |t|
      t.id = article['id']
      t.filename = url_to_filename article['url']
      t.title = article['title']
      t.group = article['section_id']
      t.labels = article['label_names']
      t.html_content = article['body']
    end
  end
end

def url_to_filename(url)
  url.scan(FILENAME_PATTERN).
     join.
     downcase.
     gsub(' ', '-').
     concat('.md')
end

def topics
  generate_topics if @topics.empty?
  @topics
end

def write_topics
  Dir.mkdir(OUTPUT_DIR) unless Dir.exist?(OUTPUT_DIR)
  topics.each do |topic|
    string = %(
---
title: #{topic.title}
group: #{topic.group}
---

#{topic.kramdown_content}
    ).strip
    file_path = File.join(OUTPUT_DIR, topic.filename)
    File.write(file_path, string)
  end
end

def download_images
  Dir.glob(FILES_TO_READ_PATTERN) do |file|
    to_dir = FULL_IMAGE_DIR
    from_file = File.read file
    Imaginizer.download_all(from_file, to_dir)
  end
end

def normalize_topics
  Dir.glob(FILES_TO_READ_PATTERN) do |file|
    content = File.read file
    normalize_image_links_in! content
    File.write file, content
  end
end

def normalize_image_links_in!(content)
  Urlizer.normalize_image_links!(content, IMAGE_DIR)
end

write_topics
download_images
normalize_topics
