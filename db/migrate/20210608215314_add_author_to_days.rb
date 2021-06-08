class AddAuthorToDays < ActiveRecord::Migration[6.0]
  def change
    add_column :days, :author, :string
  end
end
