class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  PARAMS_SIGN_UP = %i(username name email password password_confirmation).freeze
  PARAMS_USER_UPDATE = %i(username name email password
    password_confirmation current_password avatar avatar_cache
    remove_avatar).freeze

  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  has_many :rooms, dependent: :destroy
  has_many :contacts, dependent: :destroy, foreign_key: "request_sender_id"
  has_many :notifications

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  scope :search_user_by_email, (lambda do |email|
    where email: email
  end)
end
