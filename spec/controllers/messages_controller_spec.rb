require "rails_helper"

RSpec.describe MessagesController, type: :controller do
  before {
    @user1 = create(:user)
    sign_in @user1
    @user2 = create(:user, email: "hungpronguyen25@gmail.com", username: "nguyenhung2")
    @room = create :room, owner_id: @user1.id, kind: 0
    @user_room = create :user_room, user_id: @user2.id, room_id: @room.id
    @message1 = create :message, user_id: @user1.id, room_id: @room.id, kind: 0, content: "Code Ruby"
    @message2 = create :message, user_id: @user1.id, room_id: @room.id, kind: 0, content: "Code Ruby"
    @file1 = FileImage.create message_id: @message1.id, room_id: @room.id
  }

  describe "GET MessagesController#show" do
    it "show" do
      get :show, params: {message: {room_id: @room.id}}, format: :js, xhr: true
      expect(assigns(:room)).to eq @room
      expect(assigns(:messages)).to eq [@message1, @message2]
    end

    it "response success" do
      expect(response).to have_http_status 200
    end
  end

  describe "POST MessagesController#create" do
    it "create" do
      expect {
        post :create, params: {message: {room_id: @room.id, user_id: @user1.id, content: "a", kind: 0}}, format: :js, xhr: true
      }.to change(Message, :count).by(1)
    end

    it "response success" do
      expect(response).to have_http_status 200
    end
  end
end
