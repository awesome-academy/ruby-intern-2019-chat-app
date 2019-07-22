class CreateFileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :file_images do |t|
      t.references :message, foreign_key: true
      t.references :room, foreign_key: true
      t.string :file
    end
  end
end
