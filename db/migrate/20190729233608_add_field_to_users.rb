class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :integer, default: 3
  end
end
