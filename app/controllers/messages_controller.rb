class MessagesController < ApplicationController
  def show
    @room_id = message_params[:room_id]
    @room = Room.find_by id: @room_id
    @messages = Message.get_message_room @room_id
    @new_message = Message.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @message = Message.new message_params
    @room_id = message_params[:room_id]

    respond_to do |format|
      if @message.content.present? && @message.save
        ActionCable.server.broadcast "room_#{@room_id}", @message
      end
      format.js
    end
  end

  def upload_file
    @message = Message.new message_params
    @file = @message.file_images.build room_id: @message.room_id,
                                       file: params[:file]
    if @message.save && @file.save
      ActionCable.server.broadcast "room_#{@message.room_id}", @file
    else
      flash[:danger] = t("contact.errors")
    end
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :user_id, :content, :kind)
  end
end
