require 'spec_helper'

describe FV::Unified do
  describe '.new_access_token' do
    it 'requests and returns a new access token' do
      token = FV::Unified.new_access_token

      expect(token).to be_a(String)
    end

    it 'does not retry request' do
      Impostor
        .stub(:unified_login)
        .remock(:post, '/oauth/token')
        .and_return(response_code: 401, response_body: { error: 'Boo' })

      expect do
        FV::Unified.new_access_token
      end.to raise_error(FV::AuthenticationError)
    end
  end

  describe 'configuration' do
    it 'throws if configuration is invalid' do
      FV::Unified.configure do |config|
        config.client_secret = nil
      end

      expect do
        FV::Unified::User.find(1)
      end.to raise_error(FV::InvalidConfigurationError)
    end
  end

  describe '.request_access_token_from_authorization' do
    it 'returns access token' do
      result = FV::Unified.request_access_token_from_authorization(
        code: '1234',
        redirect_uri: 'https://fake.com'
      )

      expect(result).to be_a(String)
      expect(FV::Unified.api_token).to eq(result)
    end

    it 'retries once' do
      Impostor
        .stub(:unified_login)
        .remock(:post, '/oauth/token')
        .and_return(
          response_code: 401,
          response_body: { error: 'Boo' }
        )

      result = FV::Unified.request_access_token_from_authorization(
        code: '1234',
        redirect_uri: 'https://fake.com'
      )

      expect(result).to be_a(String)
    end

    it 'raises if authentication fails' do
      Impostor
        .stub(:unified_login)
        .remock(:post, '/oauth/token', time_to_live: 2)
        .and_return(
          response_code: 401,
          response_body: { error: 'Boo' }
        )

      expect do
        FV::Unified.request_access_token_from_authorization(
          code: '1234',
          redirect_uri: 'https://fake.com'
        )
      end.to raise_error(FV::AuthenticationError)
    end
  end
end
