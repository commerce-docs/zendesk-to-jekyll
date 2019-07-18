# frozen_string_literal: true

# This module converts links to images to internal topics.
module Urlizer
  IMG_PATTERN = %r{https://support.magento.com/hc/article_attachments/\d+/([^/]+.png)}.freeze
  TOPIC_PATTERN = %r{https://support.magento.com/hc/en-us/articles/(\d+)}.freeze
  def self.convert_image_links!(string, image_dir)
    file_path = File.join(image_dir, '\1')
    string.gsub!(IMG_PATTERN, file_path) if string.match? IMG_PATTERN
  end

  def self.convert_topic_links!(string, index)
    string.gsub!(TOPIC_PATTERN, index[Regexp.last_match(1)]) if string.match(TOPIC_PATTERN) && index[Regexp.last_match(1)]
  end
end
