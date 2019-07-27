class StaticPagesController < ApplicationController
  def home
    @rooms = Room.get_rooms_user current_user.id
    @messages = Message.new
    gon.current_user_id = current_user.id
  end
end
