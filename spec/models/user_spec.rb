require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  subject {user}

  describe "association" do
    it {is_expected.to have_many :rooms}
    it {is_expected.to have_many :contacts}
    it {is_expected.to have_many :notifications}
    it {is_expected.to have_many :user_rooms}
    it {is_expected.to have_many :messages}
    it {is_expected.to have_many :user_seens}
  end

  describe "column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:birthday).of_type(:datetime)}
    it {is_expected.to have_db_column(:gender).of_type(:integer)}
    it {is_expected.to have_db_column(:avatar).of_type(:string)}
    it {is_expected.to have_db_column(:admin).of_type(:boolean)}
    it {is_expected.to have_db_column(:username).of_type(:string)}
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_index(:email)}
  end

  describe "name" do
    context "valid" do
      it {is_expected.to validate_presence_of(:name)}
      it {is_expected.to validate_length_of(:name).is_at_most(Settings.user_valid.max_length_name)}
    end

    context "invalid" do
      before {subject.name = "a" * 51}
      it {is_expected.not_to be_valid}
    end
  end

  describe "user name" do
    context "valid" do
      it {is_expected.to validate_presence_of(:username)}
      it {is_expected.to validate_length_of(:username).is_at_most(Settings.user_valid.max_length_username)}
    end

    context "invalid" do
      before {subject.username = "a" * 51}
      it {is_expected.not_to be_valid}
    end
  end

  describe "email" do
    context "valid" do
      it {is_expected.to validate_presence_of(:email)}
      it {is_expected.to validate_length_of(:email).is_at_most(Settings.user_valid.max_length_email)}

      emails = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
      emails.each do |valid_email|
        it {is_expected.to allow_value(valid_email).for(:email)}
      end
    end

    context "invalid" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]

      emails.each do |invalid_email|
        it {is_expected.not_to allow_value(invalid_email).for(:email)}
      end

      before {subject.email = Faker::Internet.email(Faker::Lorem.characters(255))}
      it {is_expected.not_to be_valid}
    end

    context "unique" do
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end
  end

  describe "password" do
      context "valid" do
        it {is_expected.to validate_length_of(:password).is_at_least(Settings.user_valid.min_length_passwd)}
        it {is_expected.to validate_length_of(:password).is_at_most(Settings.user_valid.max_length_passwd)}
      end

      context "invalid" do
        before {subject.password = Faker::Lorem.characters(5)}
        it {is_expected.not_to be_valid}
      end
  end

  describe "scope" do
    it "search user by email" do
      expect(User.where(email: "hungpronguyen256@gmail.com")).to eq [subject]
    end
  end
end
