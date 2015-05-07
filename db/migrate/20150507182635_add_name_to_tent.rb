class AddNameToTent < ActiveRecord::Migration
  def change
    add_column :tents, :name, :string
  end
end
