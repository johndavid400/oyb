class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token, :string
    add_index :users, :token, unique: true
    add_column :users, :api_bible_key, :string
    add_index :users, :api_bible_key, unique: true
    add_column :users, :config, :jsonb, default: {}
  end
end
