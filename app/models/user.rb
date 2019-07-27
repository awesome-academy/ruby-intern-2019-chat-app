class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  PARAMS_SIGN_UP = %i(username name email password password_confirmation).freeze
  PARAMS_USER_UPDATE = %i(username name email password
    password_confirmation current_password avatar avatar_cache
    remove_avatar).freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  has_many :rooms, foreign_key: "owner_id"
  has_many :contacts, dependent: :destroy, foreign_key: "user_id_1"
  has_many :notifications
  has_many :user_rooms
  has_many :messages
  has_many :user_seens

  validates :username, uniqueness: true, presence: true,
    length: {maximum: Settings.user_valid.max_length_username}
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true,
    length: {maximum: Settings.user_valid.max_length_name}
  validates :email, presence: true,
    length: {maximum: Settings.user_valid.max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {maximum: Settings.user_valid.max_length_passwd,
             minimum: Settings.user_valid.min_length_passwd}

  scope :search_by_email, ->(email){where email: email}
end
