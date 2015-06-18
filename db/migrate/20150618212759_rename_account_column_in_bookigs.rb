class RenameAccountColumnInBookigs < ActiveRecord::Migration
  def change
    rename_column :bookings, :accounts_id, :account_id
  end
end
