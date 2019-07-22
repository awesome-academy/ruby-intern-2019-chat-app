class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.integer :gender
      t.string :avatar
      t.boolean :admin
      t.string :username
    end
  end
end
