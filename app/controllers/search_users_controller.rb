class SearchUsersController < ApplicationController
  def search_user_by_email
    @user = User.search_user_by_email params[:email] if params[:email]
    respond_to(&:js)
  end

  def search_user_by_email_in_list_friend
    @contacts = Contact.get_list_your_friend current_user.id
    @users = @contacts.map{|c| User.find_by id: c.user_id_2}
    @room_id = params[:room_id]
    @member = @users.select{|c| c.email == params[:email]}
    respond_to(&:js)
  end

  def get_all_users
    @users = User.limit Settings.user.limit_user
    respond_to(&:js)
  end
end
