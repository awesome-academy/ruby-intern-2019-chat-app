class StaticPagesController < ApplicationController
  def home
    @rooms = Room.get_rooms_user current_user.id
  end
end
