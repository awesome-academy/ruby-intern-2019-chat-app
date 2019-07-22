class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :notifications
  belongs_to :user_room
  belongs_to :user_seen
end
