require 'rails_helper'

RSpec.describe UserRoom, type: :model do
  describe "association" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :room}
  end

  describe "column" do
    it {is_expected.to have_db_column(:room_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:room_id)}
    it {is_expected.to have_db_index(:user_id)}
  end

  describe "scope" do
    before :each do
      @user1 = create :user, username: "hungnguyen", email: "hungpronguyen256@gmail.com", id: 1

      @room1 = create :room, id: 1, owner_id: 1, kind: 0, created_at: 3.months.ago

      @user_room = create :user_room, id: 1,room_id: 1, user_id: 1
    end

    it "get specific user in user rooms" do
      expect(UserRoom.where(user_id: 1)).to eq [@user_room]
    end

    it "get user with specific room" do
      expect(UserRoom.where(user_id: 1, room_id: 1)).to eq [@user_room]
    end
  end
end
