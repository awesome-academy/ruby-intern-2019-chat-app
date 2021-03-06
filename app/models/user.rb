class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  PARAMS_SIGN_UP = %i(username name email password password_confirmation).freeze
  PARAMS_USER_UPDATE = %i(username name email password
    password_confirmation current_password avatar avatar_cache
    remove_avatar).freeze

  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  has_many :rooms, foreign_key: "owner_id"
  has_many :contacts, dependent: :destroy, foreign_key: "user_id_1"
  has_many :notifications
  has_many :user_rooms
  has_many :messages

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  scope :search_user_by_email, ->(email){where email: email}
end
