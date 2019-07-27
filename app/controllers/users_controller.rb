class UsersController < ApplicationController
  protect_from_forgery except: :change_status

  def change_status
    @user = User.find_by id: current_user.id
    @user.update_attribute :status, params[:status]
    respond_to(&:js)
  end
end
