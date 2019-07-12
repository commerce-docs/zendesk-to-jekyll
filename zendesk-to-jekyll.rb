require 'yaml'
require_relative 'topic'
require_relative 'imaginizer'

@topics = []
OUTPUT_DIR = 'output'
IMAGE_DIR = File.join(OUTPUT_DIR, 'images')

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
      t.filename = article['name'].downcase.gsub(' ', '-').concat('.md')
      t.title = article['title']
      t.group = article['section_id']
      t.labels = article['label_names']
      t.html_content = article['body']
    end
  end
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
    file_path = File.join(OUTPUT_DIR, topic.filename)
    File.write(file_path, string)
  end
end

def download_images
  files_to_read_pattern = File.join OUTPUT_DIR, '**', '*.md'
  Dir.glob(files_to_read_pattern) do |file|
    to_dir = IMAGE_DIR
    from_file = File.read file
    Imaginizer.download_all(from_file, to_dir)
  end
end


write_topics
download_images
