class UserRoomsController < ApplicationController
  def create
    @user_room = UserRoom.new room_id: params[:room_id],
      user_id: params[:user_id], admin: false
    @member_group = @user_room.user
    respond_to(&:js) if @user_room.save
  end

  def destroy
    @user_room = UserRoom.get_user_with_specific_room params[:user_id],
      params[:room_id]
    @member_group = @user_room.first.user
    @room_id = params[:room_id]
    respond_to(&:js) if @user_room.first.present? && @user_room.first.destroy
  end

  def list_member_in_group
    @user_rooms = UserRoom.get_users_in_room params[:room_id]
    @room_id = params[:room_id]
    respond_to(&:js)
  end

  class << self
    def check_user_in_room user_id, room_id
      @room = Room.find_by id: room_id
      return true if @room && @room.owner_id == user_id
      @user_room = UserRoom.get_user_with_specific_room user_id, room_id
      return false if @user_room.first.blank?
      true
    end
  end

  def open_modal_add_friend
    @room_id = params[:room_id]
    respond_to(&:js)
  end
end
