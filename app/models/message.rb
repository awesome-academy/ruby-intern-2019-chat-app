class Message < ApplicationRecord
  has_many :file_images, dependent: :destroy
  has_many :user_seens, dependent: :destroy
  belongs_to :room
  belongs_to :user

  scope :get_message_room, ->(room_id){where room_id: room_id}

  def as_json options
    super(options).merge(user_name: user.name, created_time_at:
      created_at.strftime("%F %T"))
  end
end
