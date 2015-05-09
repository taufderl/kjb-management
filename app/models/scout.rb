class Scout < ActiveRecord::Base
  belongs_to :tent
  has_many :scout_consumptions
  
  def full_name
    self.first_name + ' ' + self.last_name
  end
  
  def account_balance
    self.scout_consumptions.map {|sc| -sc.total }.sum
  end
end
