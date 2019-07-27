class NotificationsController < ApplicationController
  def show
    @notifications = Notification.get_list_notification_of_user current_user.id
    respond_to(&:js)
  end

  def make_seen
    @notifications = Notification.get_list_notification_not_seen current_user.id
    @notifications.each do |notify|
      notify.update_attributes status: 1
    end
  end

  class << self
    def check_notification_not_seen user_id
      @notifications = Notification.get_list_notification_of_user user_id
      @notifications.each do |notify|
        true if notify.status.zero?
      end
      false
    end
  end
end
