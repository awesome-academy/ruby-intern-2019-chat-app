class SearchUsersController < ApplicationController
  def search_user_by_email
    @user = User.search_user_by_email params[:email] if params[:email]

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def get_all_users
    @users = User.limit Settings.user.limit_user

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
