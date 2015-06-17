class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :date
      t.references :accounts, index: true, foreign_key: true
      t.decimal :amount
      t.string :note1
      t.string :note2
      t.string :remarks
      t.integer :accounting_number
      t.integer :created_by_ID
      t.integer :updated_by_ID

      t.timestamps null: false
    end
  end
end