module FV
  module Unified
    class User < FV::Unified::ApiResource
      define_attribute_readers :first_name,
                               :last_name,
                               :email,
                               :is_confirmed

      has_many :companies
      has_many :servers

      def self.me
        new(client.request(:get, "#{resource_path}/me").data)
      end
    end
  end
end
