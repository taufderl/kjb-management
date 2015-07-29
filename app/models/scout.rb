class Scout < ActiveRecord::Base
  belongs_to :tent
  has_one :scout_account
  has_many :scout_consumptions

  default_scope { order :last_name } 
  
  def account
    self.scout_account || ScoutAccount.create(scout: self, name: self.full_name)
  end
  
  def full_name
    self.first_name + ' ' + self.last_name
  end
  
  def account_balance
    self.account.balance - self.scout_consumptions.map {|sc| sc.total }.sum
  end
  
  def beer_consumption
    self.scout_consumptions.sum(:beer)
  end
  
  def soft_drink_consumption
    self.scout_consumptions.sum(:soft_drink)
  end

  def sausage_consumption
    self.scout_consumptions.sum(:sausage)
  end
  
  def pork_consumption
    self.scout_consumptions.sum(:pork)
  end
  
  def turkey_consumption
    self.scout_consumptions.sum(:turkey)
  end
  
  def corn_consumption
    self.scout_consumptions.sum(:corn)
  end

end
