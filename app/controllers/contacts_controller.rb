class ContactsController < ApplicationController
  def create
    @contact_one = current_user.contacts.build contact_params
    @contact_two = Contact.new user_id_1: params[:contact][:user_id_2],
      user_id_2: current_user.id, status: 1

    respond_to do |format|
      if @contact_one.save && @contact_two.save
        format.js
      else
        flash[:danger] = t("contact.errors")
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:user_id_2, :status)
  end
end
