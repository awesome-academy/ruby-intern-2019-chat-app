class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :request_sender, foreign_key: { to_table: :users }
      t.integer :request_receiver_id
      t.integer :status
      t.timestamps
    end
  end
end
