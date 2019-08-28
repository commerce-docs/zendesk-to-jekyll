# frozen_string_literal: true

require 'net/http'
# This module detects images from the provided string and
# downloads to the provided directory (default is 'output/images').

module Imaginizer
  URL = /\!\[[^\[]+\]\(([^\(]+?)\)/.freeze

  def self.download_all(string, output_dir = 'output/images')
    string.scan URL do |url|
      write_image url.join, output_dir
    end
  end

  def self.load_image(url)
    Net::HTTP.get(URI(url))
  end

  def self.write_image(url, output_dir)
    Dir.mkdir(output_dir) unless Dir.exist?(output_dir)
    basename = File.basename(url)
    file_path = File.join(output_dir, basename)
    image = load_image url
    File.write(file_path, image)
  end
end
