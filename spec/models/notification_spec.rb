require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "association" do
    it {is_expected.to belong_to :user}
  end

  describe "column" do
    it {is_expected.to have_db_column(:title).of_type(:string)}
    it {is_expected.to have_db_column(:content).of_type(:string)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_column(:kind).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
  end

  describe "scope" do
    before :each do
      @user1 = create :user, id: 1, username: "hungnguyen",
                      email: "hungpronguyen256@gmail.com"
      @notification = create :notification, id: 1, user_id: 1, status: 0
    end
    it "get list notification of user" do
      expect(Notification.where(user_id: 1)).to eq [@notification]
    end

    it "get list notification not seen" do
      expect(Notification.where(user_id: 1, status: 0)).to eq [@notification]
    end
  end
end
