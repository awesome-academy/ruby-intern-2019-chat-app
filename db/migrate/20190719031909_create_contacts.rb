class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :request_sender, foreign_key: { to_table: :users }
      t.references :request_receiver,  foreign_key: { to_table: :users }
      t.integer :status
    end
  end
end
