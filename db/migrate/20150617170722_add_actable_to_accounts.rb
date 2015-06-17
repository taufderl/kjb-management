class AddActableToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :actable, :string
  end
end
