class AddCornToScoutConsumption < ActiveRecord::Migration
  def change
    add_column :scout_consumptions, :corn, :integer
  end
end
