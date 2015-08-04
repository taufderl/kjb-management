class Disbursement < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  validates_presence_of :user, :account, :amount

  def amount=(amount)
    if not amount.class == Float
      amount.gsub!(',', '.')
    end
    write_attribute(:amount, amount)
  end

  after_create do |disbursement|
    self.update_attributes(cleared: false)
  end
  
end
