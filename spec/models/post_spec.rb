# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  include UsersHelper
  context 'validation tests' do
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

  context 'scope tests' do
    let(:params) { { title: 'valid title', body: 'valid body', user: current_user } }
    before(:each) do
      Post.new(params).save
      Post.new(params).save
      Post.new(params).save
    end

    it 'should return all posts' do
      expect(Post.all.size).to eq(3)
    end

    it 'should return one post' do
      expect(Post.first).to_not be(nil)
    end

    it 'should return title with value valid title' do
      expect(Post.first.title).to eq('valid title')
    end

    it 'should return body with value valid body' do
      expect(Post.first.body).to eq('valid body')
    end

    it 'should return all user posts' do
      expect(current_user.posts.size).to eq(3)
    end

    it 'should return hola' do
      fizz = 'hola'
      puts fizz

      assert(fizz, 'hola')
      assert_not(fizz, 'holaaa')
    end
  end
end
