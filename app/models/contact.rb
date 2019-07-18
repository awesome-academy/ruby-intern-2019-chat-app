class Contact < ApplicationRecord
  belongs_to :user, foreign_key: "user_id_1"

  scope :get_contact_between_two_user, (lambda do |user_id_one, user_id_two|
    where user_id_1: user_id_one, user_id_2: user_id_two
  end)

  scope :get_list_friend_request, (lambda do |user_id|
    where user_id_2: user_id, status: 0
  end)

  scope :get_list_your_friend, (lambda do |user_id|
    where user_id_1: user_id, status: 2
  end)

  class << self
    def check_exist_status_contact id, other_user_id
      @contacts = Contact.get_contact_between_two_user(id, other_user_id)
      return 0 if @contacts.first.nil?
      return 1 if @contacts.first.status.zero?
      return 2 if @contacts.first.status == 1
      return 3 if @contacts.first.status == 2
    end
  end
end
