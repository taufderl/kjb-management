class Booking < ActiveRecord::Base
  belongs_to :account
  belongs_to :created_by, class_name: User
  belongs_to :updated_by, class_name: User
  belongs_to :root_booking, class_name: Booking
  has_many :sub_bookings, class_name: Booking, foreign_key: :root_booking_id
  accepts_nested_attributes_for :sub_bookings

  def amount=(amount)
    if not amount.class == Float
      amount.gsub!(',', '.')
    end
    write_attribute(:amount, amount)
  end

  def self.to_csv(filter, csv_options)
    CSV.generate(csv_options) do |csv|
      csv << column_names
      where(filter).each do |booking|
        csv << booking.attributes.values_at(*column_names)
      end
    end
  end
end
