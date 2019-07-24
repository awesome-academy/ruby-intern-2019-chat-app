class Contact < ApplicationRecord
  belongs_to :user

  scope :get_contact_between_two_user, (lambda do |user_id_one, user_id_two|
    where request_sender_id: user_id_one, request_receiver_id: user_id_two
  end)
end
