class AddDateFieldsToDay < ActiveRecord::Migration
  def change
    add_column :days, :month_of_year, :integer
    add_column :days, :day_of_month, :integer
  end
end
