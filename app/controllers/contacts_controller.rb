class ContactsController < ApplicationController
  before_action :find_contact, only: %i(update destroy)

  def create
    @contact_one = current_user.contacts.build contact_params
    @contact_two = Contact.new user_id_1: contact_params[:user_id_2],
      user_id_2: current_user.id, status: 1

    respond_to do |format|
      if @contact_one.save && @contact_two.save
        format.js
        create_notification
      else
        flash[:danger] = t("contact.errors")
      end
    end
  end

  def update
    respond_to do |format|
      status = contact_params[:status]
      update_user_one = @contact_one.update_attributes(status: status)
      update_user_two = @contact_two.update_attributes(status: status)
      if update_user_one && update_user_two
        format.js
      else
        flash[:danger] = t("contact.errors")
      end
    end
  end

  def destroy
    respond_to do |format|
      if @contact_one.destroy && @contact_two.destroy
        format.js
      else
        flash[:danger] = t("contact.errors")
      end
    end
  end

  def list_friend_request
    @contacts = Contact.get_list_friend_request current_user.id
    @users = @contacts.map{|c| User.find_by id: c.user_id_1}

    respond_to(&:js)
  end

  def list_your_friend
    @contacts = Contact.get_list_your_friend current_user.id
    @users = @contacts.map{|c| User.find_by id: c.user_id_2}
    respond_to(&:js)
  end

  private

  def contact_params
    params.require(:contact).permit(:user_id_2, :status)
  end

  def find_contact
    id_two = contact_params[:user_id_2]
    @contacts_one = Contact.get_contact_between_two_user current_user.id, id_two

    @contacts_two = Contact.get_contact_between_two_user id_two, current_user.id

    if @contacts_one.first.blank? || @contacts_two.first.blank?
      flash[:danger] = t("contact.errors")
    else
      @contact_one = @contacts_one.first
      @contact_two = @contacts_two.first
    end
  end

  def create_notification
    @content = current_user.name + t("notification.noti_add_friend")
    Notification.create user_id: contact_params[:user_id_2],
                        content: @content, kind: 1, status: 0
  end
end
