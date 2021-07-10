# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validation Model' do
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
end
