# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  include UsersHelper
  context 'Validation Model' do
    it 'ensure user presence' do
      post = Post.new(
        title: 'valid title',
        body: 'valid body',
        user: nil,
        views: 1
      ).save
      expect(post).to eq(false)
    end

    it 'ensure title presence' do
      post = Post.new(
        title: nil,
        body: 'valid body',
        user: current_user,
        views: 1
      ).save
      expect(post).to eq(false)
    end

    it 'ensure title should more than 2 characters long' do
      post = Post.new(
        title: 'w',
        body: 'valid body',
        user: current_user,
        views: 1
      ).save
      expect(post).to eq(false)
    end

    it 'ensure body presence' do
      post = Post.new(
        title: 'valid title',
        body: nil,
        user: current_user,
        views: 1
      ).save
      expect(post).to eq(false)
    end

    it 'ensure body should have between 5 and 100 characters' do
      post = Post.new(
        title: 'valid title',
        body: 'v',
        user: current_user,
        views: 1
      ).save
      expect(post).to eq(false)
    end

    it 'ensure views is integer' do
      post = Post.new(
        title: 'valid title',
        body: 'valid body post',
        user: current_user,
        views: 'test'
      ).save
      expect(post).to eq(false)
    end
  end
end
