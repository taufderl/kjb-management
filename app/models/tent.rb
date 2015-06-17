class Tent < ActiveRecord::Base
  has_many :children
  has_many :scouts
end
