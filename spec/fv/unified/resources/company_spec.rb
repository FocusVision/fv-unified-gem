require 'spec_helper'

describe FV::Unified::Company do
  describe '.resource_path' do
    it 'returns correct path' do
      expect(FV::Unified::Company.resource_path).to eq('/companies')
    end
  end

  describe '.resource_type' do
    it 'returns plural resource type' do
      expect(FV::Unified::Company.resource_type).to eq('companies')
    end
  end

  describe '.all' do
    it 'gets all companies' do
      companies = FV::Unified::Company.all

      expect(companies).to be_an(Array)
      expect(companies.count).to eq(2)
      expect(companies.first.id).to be_an(Integer)
      expect(companies.first.name).to be_a(String)
      expect(companies.first.salesforce_id).to be_a(String)
    end

    it 'retries if authentication fails' do
      Impostor
        .stub(:unified_login)
        .remock(:get, '/companies')
        .and_return(
          response_code: 401,
          response_body: { errors: [{ code: '401', status: '401' }] }
        )
      companies = FV::Unified::Company.all

      expect(companies).to be_an(Array)
      expect(companies.count).to eq(2)
      expect(companies.first.id).to be_an(Integer)
      expect(companies.first.name).to be_a(String)
      expect(companies.first.salesforce_id).to be_a(String)
    end

    it 'only retries once' do
      Impostor
        .stub(:unified_login)
        .remock(:get, '/companies', time_to_live: 2)
        .and_return(
          response_code: 401,
          response_body: { errors: [{ code: '401', status: '401' }] }
        )

      expect do
        FV::Unified::Company.all
      end.to raise_error(FV::AuthenticationError)
    end

    it 'only tries to get a new token once' do
      unified_login = Impostor.stub(:unified_login)
      unified_login
        .remock(:get, '/companies')
        .and_return(
          response_code: 401,
          response_body: { errors: [{ code: '401', status: '401' }] }
        )
      unified_login
        .remock(:post, '/oauth/token')
        .and_return(
          response_code: 401,
          response_body: { errors: [{ code: '401', status: '401' }] }
        )

      expect do
        FV::Unified::Company.all
      end.to raise_error(FV::AuthenticationError)
    end
  end

  describe '.where' do
    it 'filters companies' do
      companies = FV::Unified::Company.where(
        salesforce_id: 'TESTCO'
      )

      expect(companies).to be_an(Array)
      expect(companies.count).to eq(1)
      expect(companies.first.id).to be_an(Integer)
      expect(companies.first.name).to be_a(String)
      expect(companies.first.salesforce_id).to eq('TESTCO')
    end
  end

  describe '.find' do
    it 'finds a company by id' do
      company = FV::Unified::Company.find(8)

      expect(company).to be_a(FV::Unified::Company)
      expect(company.id).to eq(8)
      expect(company.name).to be_a(String)
      expect(company.salesforce_id).to be_a(String)
    end
  end

  describe '.create' do
    it 'creates a new company with attributes' do
      company = FV::Unified::Company.create(
        name: 'My Co',
        salesforce_id: 'MYCO'
      )

      expect(company).to be_a(FV::Unified::Company)
      expect(company.id).to be_an(Integer)
      expect(company.name).to eq('My Co')
      expect(company.salesforce_id).to eq('MYCO')
    end
  end

  describe '#to_hash' do
    it 'is reversible' do
      company_hash = FV::Unified::Company.find(1).to_hash

      expect(FV::Unified::Company.new(company_hash).to_hash).to eq(company_hash)
    end
  end
end
