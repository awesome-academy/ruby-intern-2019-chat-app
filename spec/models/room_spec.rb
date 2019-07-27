require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "association" do
    it {is_expected.to have_many :user_rooms}
    it {is_expected.to have_many :file_images}
    it {is_expected.to have_many :messages}
    it {is_expected.to belong_to :user}
  end

  describe "column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:description).of_type(:string)}
    it {is_expected.to have_db_column(:owner_id).of_type(:integer)}
    it {is_expected.to have_db_column(:kind).of_type(:integer)}
    it {is_expected.to have_db_index(:owner_id)}
  end

  describe "scope" do
    before :each do
      @user1 = create :user, id: 1, username: "hungnguyen",
        email: "hungpronguyen256@gmail.com"

      @user2 = create :user, id: 2,username: "thaitien",
        email: "thaithitien97@gmail.com"

      @room1 = create :room, id: 1, owner_id: 1, kind: 0, created_at: 3.months.ago

      @room2 = create :room, id: 2, owner_id: 1, kind: 0, created_at: 4.months.ago

      @room3 = create :room, id: 3, owner_id: 1, kind: 0, created_at: 5.months.ago
      @user_rooms = create :user_room, id: 1,room_id: 1, user_id: 2
    end

    it "rooms desc" do
      expect(Room.order created_at: :desc).to eq [@room1, @room2, @room3]
    end

    it "get room two person of user is owner" do
      expect(Room.joins(:user_rooms).where(owner_id: 1, kind: 0,
        user_rooms: {user_id: 2}) | Room.joins(:user_rooms).where(owner_id: 2, kind: 0,
        user_rooms: {user_id: 1})).to eq [@room1]
    end

    it "get rooms user" do
      expect(Room.where(owner_id: 1) +
        Room.joins(:user_rooms).where(user_rooms: {user_id: 1})).to eq [@room1, @room2, @room3]
    end
  end
end
