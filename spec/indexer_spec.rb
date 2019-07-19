require 'indexer'
RSpec.describe Indexer do

  before do
    topic1 = Topic.new do |t|
      t.id = 360000815673
      t.filename = 'update-shared-catalog-prices-using-rest-api.md'
      t.title = 'Update Shared Catalog prices using REST API'
      t.group = 115001031574
      t.html_content = '<h1>Hello World<h1>'
    end

    topic2 = Topic.new do |t|
      t.id = 360000815765
      t.filename = 'update-catalog-prices-using-rest-api.md'
      t.title = 'Update Catalog prices using REST API'
      t.group = 115001031487
      t.html_content = '<h1>Hello World Again<h1>'
    end

    @topics = [topic1, topic2]
  end

  it 'generates a hash' do
    expect(Indexer.generate_index(@topics)).to be_a Hash
  end

  it 'is not empty' do
    expect(Indexer.generate_index(@topics)).not_to be_empty
  end

  it 'returns values from provided objects' do
    expect(Indexer.generate_index(@topics)).to eq({ '360000815673' => 'update-shared-catalog-prices-using-rest-api.md', '360000815765' => 'update-catalog-prices-using-rest-api.md' })
  end
end
