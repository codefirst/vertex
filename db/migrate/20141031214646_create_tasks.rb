class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :row_order
      t.integer :user_id
      t.boolean :done
      t.timestamps
      t.index :row_order
      t.index :user_id
    end
  end
end
