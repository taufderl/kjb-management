class AddNoteToDisbursement < ActiveRecord::Migration
  def change
    add_column :disbursements, :note, :string
  end
end
