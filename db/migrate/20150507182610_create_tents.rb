class CreateTents < ActiveRecord::Migration
  def change
    create_table :tents do |t|
      t.integer :number

      t.timestamps null: false
    end
  end
end
