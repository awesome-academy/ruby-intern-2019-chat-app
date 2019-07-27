require "rails_helper"

RSpec.describe UserRoomsController, type: :controller do
  before {
    @user1 = User.create id: 1, name: "Nguyen Ba Hung", username: "hungnguyen",
                         email: "hungpronguyen25@gmail.com", password: "12345678", password_confirmation: "12345678"

    @room1 = Room.create id:1, name: "VTASK", description: "Phan mem quan ly CV",
                         owner_id: 1, kind: 0, created_at: 3.months.ago
    sign_in @user1
  }
  describe "POST user_rooms#create" do

    context "with valid attributes" do
      it "create a new user_rooms" do
        expect {
          post :create, params: {room_id: 1, user_id: 1, admin: false }, format: :js
        }.to change(UserRoom, :count).by(1)
      end
      it "respond success" do
        expect(response).to	have_http_status 200
      end
    end
  end

  describe "DELETE user_rooms#destroy" do
    before :each do
      create(:user_room, room_id: 1, id: 1, user_id: 1)
    end

    context "with valid attributes" do
      it "delete a user_rooms" do
        expect {
          delete :destroy, params: {room_id: 1, user_id: 1 }, format: :js
        }.to change(UserRoom, :count).by(-1)
      end
      it "respond success" do
        expect(response).to	have_http_status 200
      end
    end
  end

  describe "GET user_rooms#list_member_in_group" do
    before :each do
      @user_rooms = create(:user_room, id: 1, user_id: 1, room_id: 1)
    end

    context "with valid attributes" do
      it "list member in group" do
        get :list_member_in_group, params: {room_id: 1},format: :js
        expect(assigns(:user_rooms)).to eq([@user_rooms])
      end
      it "respond success" do
        expect(response).to	have_http_status 200
      end
    end
  end

  describe "open modal add friend" do
    it "respond success" do
      get :open_modal_add_friend, params: {room_id: 1}, format: :js
      expect(response).to have_http_status(200)
    end
  end
end
