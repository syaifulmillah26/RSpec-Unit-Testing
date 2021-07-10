module UsersHelper
  def current_user
    User.first_or_create(email: 'saiful@rubyh.co', password: '111111')
  end

  def user
    User.first_or_create(email: 'saiful@rubyh.co', password: '111111')
  end
end
