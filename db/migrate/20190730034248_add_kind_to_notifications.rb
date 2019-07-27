class AddKindToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :kind, :integer
  end
end
