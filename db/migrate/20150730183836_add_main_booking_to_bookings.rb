class AddMainBookingToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :root_booking, index: true, foreign_key: true
  end
end
