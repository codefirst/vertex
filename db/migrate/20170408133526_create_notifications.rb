class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :kind
      t.string :token

      t.timestamps
    end
  end
end
