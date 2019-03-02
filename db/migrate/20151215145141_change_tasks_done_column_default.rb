class ChangeTasksDoneColumnDefault < ActiveRecord::Migration[4.2]
  def change
    change_column_default(:tasks, :done, false)
  end
end
