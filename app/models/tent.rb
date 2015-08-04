class Tent < ActiveRecord::Base
  has_many :children
  has_many :scouts
  validates_presence_of :number

end
