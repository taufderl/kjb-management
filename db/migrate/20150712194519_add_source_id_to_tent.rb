class AddSourceIdToTent < ActiveRecord::Migration
  def change
    add_column :tents, :source_id, :integer
  end
end
