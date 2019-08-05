require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "association" do
    it {is_expected.to belong_to :user}
  end

  describe "column" do
    it {is_expected.to have_db_column(:user_id_1).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id_2).of_type(:integer)}
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id_1)}
  end

  describe "scope" do
    before :each do
      @user1 = create :user, id: 1, username: "hungnguyen",
                      email: "hungpronguyen256@gmail.com"
      @user2 = create :user, id: 2, username: "thaitien",
                      email: "thaitien97@gmail.com"

      @user3 = create :user, id: 3, username: "thainhung",
                           email: "thainhung95@gmail.com"
      @contact1 = Contact.create user_id_1: 1, user_id_2: 2, status: 0
      @contact2 = Contact.create user_id_1: 2, user_id_2: 1, status: 1
      @contact3 = Contact.create user_id_1: 2, user_id_2: 3, status: 2
      @contact4 = Contact.create user_id_1: 3, user_id_2: 2, status: 2
    end
    it "get contact between two user" do
      expect(Contact.where(user_id_1: 1, user_id_2: 2)).to eq [@contact1]
    end

    it "get list friend request" do
      expect(Contact.where(user_id_1: 2, status: 1)).to eq [@contact2]
    end

    it "get list your friend" do
      expect(Contact.where(user_id_1: 2, status: 2)).to eq [@contact3]
    end
  end
end
