require 'spec_helper'

describe FV::Unified::ApiResource do
  module Test
    class TestResource < FV::Unified::ApiResource
    end
  end

  describe '.resource_type' do
    it 'dasherizes name' do
      expect(Test::TestResource.resource_type).to eq('test-resources')
    end
  end

  describe '.serialize' do
    it 'dasherizes attribute names' do
      expect(
        Test::TestResource.serialize(attr_a: 1, attr_b: 2)
      ).to eq(
        {
          data: {
            type: 'test-resources',
            attributes: { 'attr-a' => 1, 'attr-b' => 2 }
          }
        }.to_json
      )
    end
  end
end
