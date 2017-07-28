module FV
  module Unified
    class Company < FV::Unified::ApiResource
      define_attribute_readers :name,
                               :salesforce_id
    end
  end
end
