# frozen_string_literal: true

require 'yaml'

Dir.glob('lib/**/*.rb') { |file| require_relative(file) }

@topics = []
@config = Config.instance.load_from_yaml
OUTPUT_DIR = @config['output_directory']
IMAGE_DIR = @config['directory_with_images']
FULL_IMAGE_DIR = File.join(OUTPUT_DIR, IMAGE_DIR)
FILES_TO_READ_PATTERN = File.join OUTPUT_DIR, '**', '*.md'
INDEX_FILE = 'index.yml'


def from_file
  ARGV[0] || raise('Provide a JSON file with content from Zendesk. For example, ruby zendesk-to-kramdown.rb how-to.json')
end

def config
  @config.config
end

def generate_topics
  @topics = Generator.generate_topics(from_file)
end

def write_topics_to(dir)
  generate_topics
  Dir.mkdir(dir) unless Dir.exist?(dir)
  @topics.each do |topic|
    string = %(
---
title: #{topic.title}
group: #{topic.group}
zendesk_id: #{topic.id}
---

#{topic.kramdown_content}
    ).strip
    file_path = File.join(OUTPUT_DIR, topic.filename)
    File.write(file_path, string)
  end
end

def download_images_to(to_dir)
  Dir.glob(FILES_TO_READ_PATTERN) do |file|
    from_file = File.read file
    Imaginizer.download_all(from_file, to_dir)
  end
end

def normalize_topics
  Dir.glob(FILES_TO_READ_PATTERN) do |file|
    content = File.read file
    convert_image_links_in! content
    convert_topic_links! content
    File.write file, content
  end
end

def convert_image_links_in!(content)
  Urlizer.convert_image_links!(content, IMAGE_DIR)
end

def convert_topic_links!(content)
  topics_index = YAML.load_file INDEX_FILE
  Urlizer.convert_topic_links!(content, topics_index)
end

def create_index_in(file, from_topics)
  Indexer.write_index_in(file, from_topics)
end

puts 'Writing topics'
write_topics_to OUTPUT_DIR

puts 'Downloading linked images'
download_images_to FULL_IMAGE_DIR

puts 'Generating index file for topics'
create_index_in INDEX_FILE, @topics

puts 'Converting links to images and internal topics'
normalize_topics
