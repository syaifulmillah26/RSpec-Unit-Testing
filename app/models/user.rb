class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  alias_method :authenticate, :valid_password?

  has_many :posts, dependent: :destroy

  scope :active_users, -> { where(is_active: true) }
  scope :inactive_users, -> { where(is_active: false) }
end
