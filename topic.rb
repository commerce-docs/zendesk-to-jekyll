require_relative 'convertable'

class Topic
  attr_accessor :id, :filename, :title, :group, :labels, :html_content, :kramdown_content
  def initialize
    yield self if block_given?
  end
  def kramdown_content
    Convertable.kramdownify(html_content)
  end
end