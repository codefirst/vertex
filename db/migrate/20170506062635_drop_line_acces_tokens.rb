class DropLineAccesTokens < ActiveRecord::Migration[4.2]
  def change
    drop_table :line_access_tokens
  end
end
