class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :content
      t.references :user, foreign_key: true
      t.integer :status
    end
  end
end
