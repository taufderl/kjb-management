class User < ActiveRecord::Base
  has_many :news
  has_many :bookings_created, class_name: "Booking", foreign_key: :created_by_id
  has_many :bookings_updated, class_name: "Booking", foreign_key: :updated_by_id

  validates_presence_of :name
end
