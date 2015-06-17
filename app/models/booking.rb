class Booking < ActiveRecord::Base
  belongs_to :accounts
  
  def created_by
    User.find(self.created_by_ID)
  end
  
  def updated_by
    User.find_by_id(self.updated_by_ID)
  end
end
