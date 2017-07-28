require 'fv'
require 'fv/unified/api_resource'
require 'fv/unified/resources'
require 'fv/unified/configuration'

module FV
  module Unified
    extend FV::Client

    configuration_class FV::Unified::Configuration

    def self.handle_authentication_failure
      configuration.api_token = new_access_token
    end

    def self.new_access_token
      response = request_new_access_token
      response.json[:access_token]
    end

    def self.request_new_access_token
      http_response_for do
        send_request(
          :post,
          '/oauth/token',
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
          params: {
            grant_type: 'client_credentials',
            client_id: configuration.client_id,
            client_secret: configuration.client_secret
          }
        )
      end
    end

    def self.request_access_token_from_authorization(code:, redirect_uri:)
      response = request(
        :post,
        '/oauth/token',
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
        params: {
          grant_type: 'authorization_code',
          code: code,
          client_id: configuration.client_id,
          client_secret: configuration.client_secret,
          redirect_uri: redirect_uri
        }
      )
      configuration.api_token = response.json[:access_token]
    end
  end
end
