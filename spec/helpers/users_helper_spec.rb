module UsersHelper
  def current_user
    User.first_or_create(email: 'saiful@rubyh.co', password: '111111')
  end

  def user
    User.first_or_create(email: 'saiful@rubyh.co', password: '111111')
  end

  def auth_token
    Knock::AuthToken.new(payload: { sub: current_user.id }).token
  end
end
