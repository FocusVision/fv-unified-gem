module FV
  module Unified
    class ApiResource < FV::ApiResource
      def self.transform_key_for_api(key)
        super.dasherize
      end

      define_attribute_readers :created_at,
                               :updated_at
    end
  end
end
