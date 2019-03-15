class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.datetime :date
      t.string :chapter
      t.text :excerpt
      t.text :devotional
      t.string :ot
      t.string :nt
      t.string :psalm
      t.string :proverb
      t.integer :month_of_year
      t.integer :day_of_month

      t.timestamps
    end
  end
end
