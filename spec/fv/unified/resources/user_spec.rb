require 'spec_helper'

describe FV::Unified::User do
  describe '.resource_path' do
    it 'returns correct path' do
      expect(FV::Unified::User.resource_path).to eq('/users')
    end
  end

  describe '.resource_type' do
    it 'returns plural resource type' do
      expect(FV::Unified::User.resource_type).to eq('users')
    end
  end

  describe '.all' do
    it 'gets all users' do
      users = FV::Unified::User.all

      expect(users).to be_an(Array)
      expect(users.count).to eq(2)
      expect(users.first.id).to be_an(Integer)
      expect(users.first.first_name).to be_a(String)
      expect(users.first.last_name).to be_a(String)
      expect(users.first.email).to be_a(String)
      expect(users.first.created_at).to be_a(String)
      expect(users.first.updated_at).to be_a(String)
    end
  end

  describe '.where' do
    it 'filters users' do
      users = FV::Unified::User.where(
        email: 'test@mail.com'
      )

      expect(users).to be_an(Array)
      expect(users.count).to eq(1)
      expect(users.first.id).to be_an(Integer)
      expect(users.first.first_name).to be_a(String)
      expect(users.first.last_name).to be_a(String)
      expect(users.first.email).to eq('test@mail.com')
    end
  end

  describe '.find' do
    it 'finds a user by id' do
      user = FV::Unified::User.find(8)

      expect(user).to be_a(FV::Unified::User)
      expect(user.id).to eq(8)
      expect(user.first_name).to be_a(String)
      expect(user.last_name).to be_a(String)
      expect(user.email).to be_a(String)
    end
  end

  describe '.me' do
    it 'gets the user from the current access token' do
      user = FV::Unified::User.me

      expect(user).to be_a(FV::Unified::User)
      expect(user.id).to be_an(Integer)
      expect(user.first_name).to be_a(String)
      expect(user.last_name).to be_a(String)
      expect(user.email).to be_a(String)
    end
  end

  describe '.reset_password_token' do
    it 'gets a reset password token for the current user' do
      token = FV::Unified::User.reset_password_token

      expect(token).to be_a(String)
    end
  end

  describe '.reset_password_link' do
    it 'gets a reset password link for the current user' do
      token = FV::Unified::User.reset_password_link

      expect(token).to be_a(String)
    end
  end

  describe '.set_password_link' do
    it 'gets a set password link for the current user' do
      token = FV::Unified::User.set_password_link

      expect(token).to be_a(String)
    end
  end

  describe '#to_hash' do
    it 'is reversible' do
      user_hash = FV::Unified::User.find(1).to_hash

      expect(FV::Unified::User.new(user_hash).to_hash).to eq(user_hash)
    end
  end
end
