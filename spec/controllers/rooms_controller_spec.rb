require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  before {
    @user1 = create(:user)
    @user2 = create(:user, email: "hungpronguyen25@gmail.com", username: "nguyenhung2")
    @user3 = create(:user, email: "hungpronguyen2@gmail.com", username: "nguyenhung3")
    sign_in @user1
  }

  describe "before action" do
    it {is_expected.to use_before_action(:find_rooms)}
  end

  describe "POST RoomsController#create" do
    context "valid params" do
      it "don't have rooms in find_rooms" do
        post :create, params: {room: {user_id: @user2.id, kind: 0}}, format: :js, xhr: true
        expect(assigns(:rooms)).to eq []
        expect(assigns(:user)).to eq @user2
        expect(assigns(:room).name).to eq @user2.name
        expect(response).to have_http_status(200)
      end

      it "have rooms in find_rooms" do
        @room = create :room, owner_id: @user1.id, kind: 0
        @user_room = create :user_room, user_id: @user2.id, room_id: @room.id
        post :create, params: {room: {user_id: @user2.id, kind: 0}}, format: :js, xhr: true
        expect(assigns(:room)).to eq @room
        expect(assigns(:user_room)).to eq @user_room
      end
    end
  end

  describe "GET RoomsController#list_file_room" do
    it "list file room" do
      @room = create :room, owner_id: @user1.id, kind: 0
      @user_room = create :user_room, user_id: @user2.id, room_id: @room.id
      @message1 = create :message, user_id: @user1.id, room_id: @room.id, kind: 1
      @message2 = create :message, user_id: @user1.id, room_id: @room.id, kind: 1
      @file1 = FileImage.create message_id: @message1.id, room_id: @room.id
      @file2 = FileImage.create message_id: @message2.id, room_id: @room.id

      get :list_file_room, params: {room_id: @room.id}, format: :js, xhr: true
      expect(assigns(:files)).to eq [@file1, @file2]
    end
  end

  describe "POST RoomsController#create_group" do
    it "create group" do
      expect {post :create_group, params: {name: "Vtask", description: "Ngay mai se khac"}.to
        change(Room, :count).by(1)
      }
    end
    it "respond success" do
      expect(response).to	have_http_status 200
    end
  end
end
