require 'rails_helper'

RSpec.describe UserSeen, type: :model do
  describe "association" do
    it {is_expected.to belong_to :message}
    it {is_expected.to belong_to :user}
  end

  describe "column" do
    it {is_expected.to have_db_column(:message_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_index(:message_id)}
    it {is_expected.to have_db_index(:user_id)}
  end
end
