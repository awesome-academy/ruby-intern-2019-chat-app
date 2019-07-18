class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :file_images, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :user, foreign_key: "owner_id"

  scope :rooms_desc, ->{order created_at: :desc}

  scope :get_room_two_person_of_user_is_owner,
    (lambda do |user_id_one, user_id_two|
      joins(:user_rooms).where(owner_id: user_id_one, kind: 0,
        user_rooms: {user_id: user_id_two}) +
        joins(:user_rooms).where(owner_id: user_id_two, kind: 0,
          user_rooms: {user_id: user_id_one})
    end)

  scope :get_rooms_user, (lambda do |user_id|
    where(owner_id: user_id) +
      joins(:user_rooms).where(user_rooms: {user_id: user_id})
  end)
end
