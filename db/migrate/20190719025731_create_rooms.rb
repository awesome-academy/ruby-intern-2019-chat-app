class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :owner_id
      t.integer :type
    end
  end
end
