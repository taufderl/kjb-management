class CreateScoutConsumptions < ActiveRecord::Migration
  def change
    create_table :scout_consumptions do |t|
      t.date :date
      t.references :scout, index: true, foreign_key: true
      t.integer :beer
      t.integer :soft_drink
      t.integer :sausage
      t.integer :pork
      t.integer :turkey
      t.decimal :other, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
