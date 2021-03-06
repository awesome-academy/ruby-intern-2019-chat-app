class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.references :owner, foreign_key: { to_table: :users }
      t.integer :type
      t.timestamps
    end
  end
end
