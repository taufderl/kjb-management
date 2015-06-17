class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :date
      t.references :accounts, index: true, foreign_key: true
      t.decimal :amount
      t.String :note1
      t.String :note2
      t.String :remarks
      t.user :created_by
      t.user :updated_by
      t.string :accounting_number

      t.timestamps null: false
    end
  end
end
