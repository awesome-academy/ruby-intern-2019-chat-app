class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :contacts, :request_sender_id, :user_id_1
    rename_column :contacts, :request_receiver_id, :user_id_2
  end
end
