class FixScoutAndChildAccountsTables < ActiveRecord::Migration
  def self.up
    rename_table :scouts_accounts, :scout_accounts
    rename_table :children_accounts, :child_accounts
    rename_column :scout_accounts, :scouts_id, :scout_id
    rename_column :child_accounts, :children_id, :child_id
  end
  def self.down
    rename_column :scout_accounts, :scout_id, :scouts_id
    rename_column :child_accounts, :child_id, :children_id
    rename_table :scout_accounts, :scouts_accounts
    rename_table :child_accounts, :children_accounts
  end
end
