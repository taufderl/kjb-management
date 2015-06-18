class Account < ActiveRecord::Base
  actable
  validates_presence_of :name
  has_many :bookings
end
