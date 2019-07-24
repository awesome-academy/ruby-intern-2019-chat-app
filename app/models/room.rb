class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :file_images, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :user
  attr_reader :email
end
