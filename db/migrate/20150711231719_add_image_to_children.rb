class AddImageToChildren < ActiveRecord::Migration
  def change
    add_column :children, :image, :binary
  end
end
