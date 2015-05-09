class Child < ActiveRecord::Base
  belongs_to :tent
  has_many :child_consumptions
  def full_name
    first_name + ' ' + last_name
  end
  
  def account_balance
    self.child_consumptions.map {|sc| -sc.total }.sum
  end
end
