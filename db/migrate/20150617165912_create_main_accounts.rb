class CreateMainAccounts < ActiveRecord::Migration
  def change
    create_table :main_accounts do |t|

      t.timestamps null: false
    end
  end
end
