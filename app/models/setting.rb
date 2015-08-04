class Setting < ActiveRecord::Base
  self.inheritance_column = nil
  validates_presence_of :type, :key, :value
end
