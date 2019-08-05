require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  before {
    @user1 = User.create id: 1, name: "Nguyen Ba Hung", username: "hungnguyen",
                         email: "hungpronguyen25@gmail.com", password: "12345678", password_confirmation: "12345678",
                         status: 1

    @room = Room.create id:1, name: "VTASK", description: "Phan mem quan ly CV",
                         owner_id: 1, kind: 0, created_at: 3.months.ago

    sign_in @user1
  }

  describe "GET StaticPagesController#home" do
    it "load home success" do
      get :home
      expect(assigns(:rooms)).to eq([@room])
      expect(response).to have_http_status(200)
    end
  end
end
