require "rails_helper"

RSpec.describe SearchUsersController, type: :controller do
  before {
    @user1 = create(:user, id: 1)
    sign_in @user1
  }

  describe "GET SearchUsersController#search_user_by_email" do
    it "get user by email in database" do
      get :search_user_by_email,params: {email: "hungpronguyen256@gmail.com"}, format: :js, xhr: true
      expect(assigns(:user)).to eq([@user1])
    end

    it "get user by email not in database" do
      get :search_user_by_email, params: {email: "hungpronguyen25@gmail.com"}, format: :js, xhr: true
      expect(assigns(:user)).to eq([])
    end

    it "response success" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET SearchUsersController#search_by_email_in_list_friend" do
    before :each do
      @user2 = create(:user, email: "hungpronguyen25@gmail.com", username: "nguyenbahung2")
      @user3 = create(:user, email: "hungpronguyen2@gmail.com", username: "nguyenbahung3")
      @contact = Contact.create user_id_1: @user1.id, user_id_2: @user2.id, status:2
      @contact1 = Contact.create user_id_1: @user2.id, user_id_2: @user1.id, status:2
      @contact2 = Contact.create user_id_1: @user1.id, user_id_2: @user3.id, status: 2
      @contact3 = Contact.create user_id_1: @user3.id, user_id_2: @user1.id, status: 2
      @room = Room.create id: 1, name: "VTASK", description: "Phan mem quan ly CV",
        owner_id: 1, kind: 0, created_at: 3.months.ago
    end

    context "valid params[:email]" do
      it "search by email in list friend" do
        get :search_by_email_in_list_friend, params: {email: "hungpronguyen25@gmail.com", room_id: @room.id}, format: :js, xhr: true
        expect(assigns(:contacts)).to eq ([@contact, @contact2])
        expect(assigns(:users)).to eq ([@user2, @user3])
        expect(assigns(:room_id)).to eq (@room.id.to_s)
        expect(assigns(:member)).to eq ([@user2])
      end

      it "response success" do
        expect(response).to have_http_status(200)
      end
    end
    context "invalid params[:email]" do
      it "search by email in list friend" do
        get :search_by_email_in_list_friend, params: {email: "hungpronguyen@gmail.com", room_id: @room.id}, format: :js, xhr: true
        expect(assigns(:room_id)).to eq (@room.id.to_s)
        expect(assigns(:member)).to eq ([])
      end

      it "response success" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET SearchUsersController#get_all_users" do
    before :each do
      @user2 = create(:user, email: "hungpronguyen25@gmail.com", username: "nguyenbahung2")
      @user3 = create(:user, email: "hungpronguyen2@gmail.com", username: "nguyenbahung3")
    end

    it "get all user" do
      get :get_all_users, format: :js, xhr: true
      expect(assigns[:users]).to eq [@user1, @user2, @user3]
    end

    it "response success" do
      expect(response).to have_http_status(200)
    end
  end
end
