class CreateSchedules < ActiveRecord::Migration[4.2]
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.string :cron

      t.timestamps
      t.index :user_id
    end
  end
end
