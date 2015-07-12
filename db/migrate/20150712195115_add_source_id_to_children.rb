class AddSourceIdToChildren < ActiveRecord::Migration
  def change
    add_column :children, :source_id, :integer
  end
end
