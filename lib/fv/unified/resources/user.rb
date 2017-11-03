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

      def reset_password_token
        reset_password_json[:token]
      end

      def set_password_link
        reset_password_json[:set_link]
      end

      def reset_password_link
        reset_password_json[:reset_link]
      end

      def reset_password_json
        self.class.client.request(
          :get,
          "#{self.class.resource_path}/#{id}/reset-password"
        ).json
      end
    end
  end
end
