class RenameDisbursementFieldAccount < ActiveRecord::Migration
  def change
    rename_column :disbursements, :accounts_id, :account_id
  end
end
