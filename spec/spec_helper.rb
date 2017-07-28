require 'fv_unified'
require 'pry'
require 'impostor'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    FV::Unified.configure do |ul|
      ul.api_url = 'https://api-qa.focusvision.com'
      ul.client_id = 'test-app'
      ul.client_secret = '1234HASHSECRET'
    end
    Impostor.stub(:unified_login)
  end
end
