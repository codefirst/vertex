class DropLineAccesTokens < ActiveRecord::Migration
  def change
    drop_table :line_access_tokens
  end
end
