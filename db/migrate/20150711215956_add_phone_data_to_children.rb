class AddPhoneDataToChildren < ActiveRecord::Migration
  def change
    add_column :children, :phone, :string
  end
end
