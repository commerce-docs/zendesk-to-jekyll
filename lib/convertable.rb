require 'kramdown'

module Convertable
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
