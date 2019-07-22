class CreateUserSeen < ActiveRecord::Migration[5.2]
  def change
    create_table :user_seens do |t|
      t.references :message, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status
    end
  end
end
