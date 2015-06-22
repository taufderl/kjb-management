class RenameBookingForeignKeys < ActiveRecord::Migration
  def self.up
    rename_column :bookings, :created_by_ID, :created_by_id
    rename_column :bookings, :updated_by_ID, :updated_by_id
  end
  def self.down
    rename_column :bookings, :created_by_id, :created_by_ID
    rename_column :bookings, :updated_by_id, :updated_by_ID
  end
end
