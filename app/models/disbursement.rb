class Disbursement < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  def amount=(amount)
    if not amount.class == Float
      amount.gsub!(',', '.')
    end
    write_attribute(:amount, amount)
  end

  do |disbursement|
    self.update_attributes(cleared: false)
  end
  
end
