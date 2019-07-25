class Contact < ApplicationRecord
  belongs_to :user, foreign_key: "request_sender_id"

  scope :get_contact_between_two_user, (lambda do |user_id_one, user_id_two|
    where request_sender_id: user_id_one, request_receiver_id: user_id_two
  end)

  class << self
    def check_exist_status_contact id, other_user_id
      @contacts = Contact.get_contact_between_two_user(id, other_user_id)
      return 0 if @contacts.first.nil?
      return 1 if @contacts.first.status.zero?
      return 2 if @contacts.first.status == 1
    end
  end
end
