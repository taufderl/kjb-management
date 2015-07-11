class Child < ActiveRecord::Base
  belongs_to :tent
  has_one :child_account
  has_many :child_consumptions
  
  def account
    self.child_account || ChildAccount.create(child: self, name: self.full_name)
  end
  
  def full_name
    first_name + ' ' + last_name
  end
  
  def account_balance
    self.account.balance - self.child_consumptions.map {|sc| sc.total }.sum
  end
end
