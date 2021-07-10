# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensure email presence' do
      user = User.new(password: '111111', password_confirmation: '111111').save
      expect(user).to eq(false)
    end

    it 'ensure password presence' do
      user = User.new(
        email: 'saeful@rubyh.co', password_confirmation: '111111'
      ).save
      expect(user).to eq(false)
    end

    it 'ensure password and password confirmation match' do
      user = User.new(
        email: 'saeful@rubyh.co', password: '111111',
        password_confirmation: '11111'
      ).save
      expect(user).to eq(false)
    end

    it 'should have successfully' do
      user = User.new(
        email: 'saeful+1@rubyh.co', password: '111111',
        password_confirmation: '111111'
      ).save
      expect(user).to eq(true)
    end
  end

  context 'scope tests' do
    let(:params) { { password: '111111', password_confirmation: '111111' } }
    before(:each) do
      User.new(params.merge(email: 'saiful@rubyh.co', is_active: true)).save
      User.new(params.merge(email: 'saiful+1@rubyh.co', is_active: true)).save
      User.new(params.merge(email: 'saiful+2@rubyh.co')).save
      User.new(params.merge(email: 'saiful+3@rubyh.co')).save
      User.new(params.merge(email: 'saiful+4@rubyh.co')).save
    end

    it 'should return active users' do
      expect(User.active_users.size).to eq(2)
    end

    it 'should return inactive users' do
      expect(User.inactive_users.size).to eq(3)
    end
  end
end
