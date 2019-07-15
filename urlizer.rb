# frozen_string_literal: true

# This module converts links to images to internal topics.
module Urlizer
  IMG_PATTERN = %r{https://support.magento.com/hc/article_attachments/\d+/([^/]+.png)}
  def self.normalize_image_links!(string, image_dir)
    file_path = File.join(image_dir, '\1')
    string.gsub!(IMG_PATTERN, file_path) if string.match? IMG_PATTERN
  end
end
