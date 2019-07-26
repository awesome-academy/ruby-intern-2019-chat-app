class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :get_specific_user_in_user_rooms, (lambda do |user_id|
    where user_id: user_id
  end)

  scope :get_users_in_room, ->(room_id){where room_id: room_id}
end
