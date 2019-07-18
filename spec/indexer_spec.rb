require 'indexer'
RSpec.describe Indexer do
  it 'generates a hash of values' do
    Topic.new do |t|
      t.id = 360000815673
      t.filename = 'update-shared-catalog-prices-using-rest-api.md'
      t.title = 'Update Shared Catalog prices using REST API'
      t.group = 115001031574
      t.html_content = '<h1>Hello World<h1>'
    end

    Topic.new do |t|
      t.id = 360000815765
      t.filename = 'update-catalog-prices-using-rest-api.md'
      t.title = 'Update Catalog prices using REST API'
      t.group = 115001031487
      t.html_content = '<h1>Hello World Again<h1>'
    end

    expect(Indexer.generate_index_for_topics).to be_a Hash
    expect(Indexer.generate_index_for_topics).to eq({ '360000815673' => 'update-shared-catalog-prices-using-rest-api.md', '360000815765' => 'update-catalog-prices-using-rest-api.md' })
  end
end
