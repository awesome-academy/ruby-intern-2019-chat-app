class ContactsController < ApplicationController
  def create
    @contact = current_user.contacts.build contact_params
    respond_to do |format|
      if @contact.save
        format.js
      else
        flash[:danger] = t("contact.errors")
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:request_receiver_id, :status)
  end
end
