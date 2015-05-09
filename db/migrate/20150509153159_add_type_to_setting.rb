class AddTypeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :type, :string
  end
end
