require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before {
    @user1 = User.create id: 1, name: "Nguyen Ba Hung", username: "hungnguyen",
                         email: "hungpronguyen25@gmail.com", password: "12345678", password_confirmation: "12345678",
                         status: 1
    sign_in @user1
  }

  describe "change status operator user" do
    it "change success" do
      get :change_status, params: {status: 2}, format: :js
      @user1.reload
      expect(@user1.status).to eq(2)
    end
  end
end
