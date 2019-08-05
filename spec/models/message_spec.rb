require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "association" do
    it {is_expected.to have_many :file_images}
    it {is_expected.to have_many :user_seens}
    it {is_expected.to belong_to :room}
    it {is_expected.to belong_to :user}
  end

  describe "column" do
    it {is_expected.to have_db_column(:content).of_type(:string)}
    it {is_expected.to have_db_column(:room_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:kind).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_index(:room_id)}
  end

  describe "scope" do
    before :each do
      @user1 = @user1 = create :user, id: 1, username: "hungnguyen",
                               email: "hungpronguyen256@gmail.com"

      @room = create :room, id: 1, owner_id: 1, kind: 1

      @message = create :message, id: 1, room_id: 1, user_id: 1, kind: 1
    end

    it "get list message" do
      expect(Message.where(room_id: 1)).to eq [@message]
    end
  end
end
