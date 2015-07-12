class Booking < ActiveRecord::Base
  belongs_to :account
  belongs_to :created_by, class_name: User
  belongs_to :updated_by, class_name: User
  
  
  def self.to_csv(filter, csv_options)
    CSV.generate(csv_options) do |csv|
      csv << column_names
      where(filter).each do |booking|
        csv << booking.attributes.values_at(*column_names)
      end
    end
  end
end
