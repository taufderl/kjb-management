class CreateChildConsumptions < ActiveRecord::Migration
  def change
    create_table :child_consumptions do |t|
      t.references :child, index: true, foreign_key: true
      t.date :date
      t.string :time_of_day
      t.integer :soft_drink
      t.decimal :other
      t.string :created_by
      t.string :edited_by

      t.timestamps null: false
    end
  end
end
