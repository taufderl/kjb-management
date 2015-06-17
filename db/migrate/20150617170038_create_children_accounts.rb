class CreateChildrenAccounts < ActiveRecord::Migration
  def change
    create_table :children_accounts do |t|
      t.references :children, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
