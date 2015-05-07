class AddTentToScout < ActiveRecord::Migration
  def change
    add_reference :scouts, :tent, index: true, foreign_key: true
  end
end
