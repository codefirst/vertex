class CreateLineAccessTokens < ActiveRecord::Migration[4.2]
  def change
    create_table :line_access_tokens do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
