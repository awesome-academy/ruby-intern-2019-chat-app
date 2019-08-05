require 'rails_helper'

RSpec.describe FileImage, type: :model do
  describe "association" do
    it {is_expected.to belong_to :room}
    it {is_expected.to belong_to :message}
  end

  describe "column" do
    it {is_expected.to have_db_column(:message_id).of_type(:integer)}
    it {is_expected.to have_db_column(:room_id).of_type(:integer)}
    it {is_expected.to have_db_column(:file).of_type(:string)}
    it {is_expected.to have_db_index(:message_id)}
    it {is_expected.to have_db_index(:room_id)}
  end
  describe "scope" do
    before :each do
      @user1 = create :user, id: 1, username: "hungnguyen",
                               email: "hungpronguyen256@gmail.com"

      @room = create :room, id: 1, owner_id: 1, kind: 1

      @message = create :message, id: 1, room_id: 1, user_id: 1, kind: 1

      @file = FileImage.create id: 1, message_id: 1, room_id: 1, file:"avatar_default.png"
    end
    it "get list file room" do
      expect(FileImage.where(room_id: 1)).to eq [@file]
    end
  end
end
