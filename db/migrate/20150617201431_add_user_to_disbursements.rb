class AddUserToDisbursements < ActiveRecord::Migration
  def change
    add_reference :disbursements, :user, index: true, foreign_key: true
  end
end
