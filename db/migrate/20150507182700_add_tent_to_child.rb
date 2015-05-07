class AddTentToChild < ActiveRecord::Migration
  def change
    add_reference :children, :tent, index: true, foreign_key: true
  end
end
