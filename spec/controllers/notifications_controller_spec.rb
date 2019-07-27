require "rails_helper"

RSpec.describe NotificationsController, type: :controller do
  before {
    @user1 = create(:user)
    sign_in @user1
    @notification = create(:notification, user_id: @user1.id, status: 0)
  }

  describe "GET NotificationController#show" do
    it "show" do
      get :show, format: :js, xhr: true
      expect(assigns(:notifications)).to eq [@notification]
    end

    it "response success" do
      expect(response).to have_http_status 200
    end
  end
end
