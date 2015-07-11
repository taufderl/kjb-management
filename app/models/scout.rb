class Scout < ActiveRecord::Base
  belongs_to :tent
  has_one :scout_account
  has_many :scout_consumptions
  
  def account
    self.scout_account || ScoutAccount.create(scout: self, name: self.full_name)
  end
  
  def full_name
    self.first_name + ' ' + self.last_name
  end
  
  def account_balance
    self.account.balance - self.scout_consumptions.map {|sc| sc.total }.sum
  end
end
