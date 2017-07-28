module FV
  module Unified
    class Configuration < FV::Configuration
      attr_accessor :client_id,
                    :client_secret

      def valid?
        client_id && client_secret && api_url
      end
    end
  end
end
