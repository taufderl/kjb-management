class AddUserFieldsToScoutConsumption < ActiveRecord::Migration
  def change
    add_column :scout_consumptions, :created_by, :string
    add_column :scout_consumptions, :edited_by, :string
    add_column :scout_consumptions, :notes, :string
  end
end
