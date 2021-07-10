module PostsHelper
  def current_user
    User.first_or_create(email: 'saiful@rubyh.co', password: '111111')
  end

  def post_created
    Post.first_or_create(title: 'valid title', body: 'valid body', user: current_user, views: 1)
  end
end
