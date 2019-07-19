require 'config'

RSpec.describe Config do
  before do
    @config = Config.instance
  end
  it 'creates a singleton instance' do
    expect(@config).to be_a Config
  end

  it 'returns full config from config.yml' do
    expect(@config.load_from_yaml).not_to be_empty
  end

  it 'returns requested values'
end
