class Notification < ApplicationRecord
  belongs_to :user

  scope :get_list_notification_of_user, ->(user_id){where user_id: user_id}

  scope :get_list_notification_not_seen, (lambda do |user_id|
    where user_id: user_id, status: 0
  end)
end
