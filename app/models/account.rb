class Account < ActiveRecord::Base
  actable
  validates_presence_of :name
  has_many :bookings
  
  def balance
    self.bookings.map {|b| b.amount}.sum
  end
end
