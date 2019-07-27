class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :get_specific_user_in_user_rooms, ->(user_id){where user_id: user_id}

  scope :get_users_in_room, ->(room_id){where room_id: room_id}

  scope :get_user_with_specific_room, (lambda do |user_id, room_id|
    where user_id: user_id, room_id: room_id
  end)
end
