class AddNumberToChildren < ActiveRecord::Migration
  def change
    add_column :children, :number, :integer
  end
end
