class Account < ActiveRecord::Base
  actable
  
  validates_presence_of :name
end
