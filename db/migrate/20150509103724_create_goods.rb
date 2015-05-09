class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.date :date

      t.timestamps null: false
    end
  end
end
