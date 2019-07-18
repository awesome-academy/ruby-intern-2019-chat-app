class Message < ActiveRecord
  has_many :file_images, dependent: :destroy
  has_many :user_seens, dependent: :destroy
  belongs_to :room
end
