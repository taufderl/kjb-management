class CreateScoutsAccounts < ActiveRecord::Migration
  def change
    create_table :scouts_accounts do |t|
      t.references :scouts, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
