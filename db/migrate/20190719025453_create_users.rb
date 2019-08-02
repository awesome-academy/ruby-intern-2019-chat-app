class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.datetime :birthday
      t.integer :gender
      t.string :avatar
      t.boolean :admin
      t.string :username
      t.timestamps
    end
  end
end
