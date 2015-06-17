class AddActableToAccounts < ActiveRecord::Migration
  change_table :accounts do |t|
    t.actable
  end
end
