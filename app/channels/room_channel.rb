class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
  end
end
asdsaajbdvsabdf122312312312321asdasdasdasdasd'asdsaajbdvsabdf122312312312321asdasdasdasdasdasdsaa