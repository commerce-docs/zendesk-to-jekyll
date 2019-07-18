require 'generator'

RSpec.describe Generator do
  it 'starts with non-empty list of articles' do
    expect(Generator.articles('spec/how-to.json')).not_to be_empty
  end

  it 'returns an array after generation' do
    expect(Generator.generate_topics('spec/how-to.json')).to be_an Array
  end

  it 'ends with non-empty list of generated topics' do
    expect(Generator.generate_topics('spec/how-to.json')).not_to be_empty
  end
end
