class RoomsController < ApplicationController
  before_action :find_rooms, only: :create

  def create
    create_room && return if @rooms.empty?

    @room = @rooms.first
    @user_room = @room.user_rooms.first

    respond_to do |format|
      format.js
    end
  end

  def list_file_room
    @files = FileImage.get_list_files_room params[:room_id]

    respond_to do |format|
      format.js
    end
  end

  private

  def room_params
    params.require(:room).permit(:user_id, :kind)
  end

  def find_rooms
    @rooms = Room.get_room_two_person_of_user_is_owner current_user.id,
      room_params[:user_id]
    @user = User.find_by id: room_params[:user_id]
  end

  def create_room
    @room = Room.new(name: @user.name, owner_id: current_user.id,
                     kind: room_params[:kind])
    @user_room = @room.user_rooms.build user_id: room_params[:user_id],
                                        admin: false

    respond_to do |format|
      if @room.save && @user_room.save
        format.js
      else
        flash[:danger] = t("contact.errors")
      end
    end
  end
end
