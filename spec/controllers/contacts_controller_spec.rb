require "rails_helper"

RSpec.describe ContactsController, type: :controller do
  before {
    @user1 = create :user, id: 1, username: "hungnguyen",
                    email: "hungpronguyen256@gmail.com"
    @user2 = create :user, id: 2, username: "thaitien",
                    email: "thaitien97@gmail.com"

    @user3 = create :user, id: 3, username: "thainhung",
                    email: "thainhung95@gmail.com"

    @contact1 = Contact.create user_id_1: 1, user_id_2: 2, status: 0
    @contact2 = Contact.create user_id_1: 2, user_id_2: 1, status: 1
    sign_in @user1
  }

  describe "before action" do
    it {is_expected.to use_before_action(:find_contact)}
  end

  describe "POST ContactsController#create" do
    context "create contact" do
      it "create contact with valid params" do
       expect {
         post :create, params: {contact: {user_id_2: @user3.id, status: 0}}, format: :js, xhr: true
       }.to change(Contact, :count).by(2)
      end
      it "response success" do
        expect(response).to have_http_status 200
      end
    end
  end

  describe "PUT ContactsController#update" do
    context "update contact" do
      it "update contact success" do
        put :update, params: {contact: {user_id_2: @user2.id, status: 2}}, format: :js, xhr: true
        @contact1.reload
        expect(@contact1.status).to eq 2
        @contact2.reload
        expect(@contact2.status).to eq 2
      end
      it "response success" do
        expect(response).to have_http_status 200
      end
    end
  end

  describe "DELETE ContactsController#destroy" do

    context "with valid attributes" do
      it "delete a contact" do
        @contact3 = Contact.create user_id_1: 1, user_id_2: 3, status: 2
        @contact4 = Contact.create user_id_1: 3, user_id_2: 1, status: 2
        expect {
          delete :destroy, params: {contact: {user_id_2: 3} }, format: :js
        }.to change(Contact, :count).by(-2)
      end
      it "respond success" do
        expect(response).to	have_http_status 200
      end
    end
  end
end
