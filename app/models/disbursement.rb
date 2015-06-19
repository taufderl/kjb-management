class Disbursement < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  after_create do |disbursement|
    self.update_attributes(cleared: false)
  end
  
end
