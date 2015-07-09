class CreateDays < ActiveRecord::Migration
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

      t.timestamps
    end
  end
end
