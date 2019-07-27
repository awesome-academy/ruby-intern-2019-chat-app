class UsersController < ApplicationController
  def change_status
    @user = User.find_by id: current_user.id
    @user.update_attributes status: params[:status]
    respond_to(&:js)
  end
end
