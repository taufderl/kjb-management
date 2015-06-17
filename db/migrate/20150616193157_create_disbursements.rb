class CreateDisbursements < ActiveRecord::Migration
  def change
    create_table :disbursements do |t|
      t.date :date
      t.references :accounts, index: true, foreign_key: true
      t.boolean :cleared
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
