class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  has_many :rooms, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :notifications

  validates :username, uniqueness: true, presence: true
end
