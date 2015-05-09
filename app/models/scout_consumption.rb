class ScoutConsumption < ActiveRecord::Base
  belongs_to :scout
  validates_uniqueness_of :scout_id, :scope => :date
  
  
  def total
    self.beer.to_i * Good.get_price(:beer, self.date) + 
    self.soft_drink.to_i * Good.get_price(:soft_drink, self.date) + 
    self.sausage.to_i * Good.get_price(:sausage, self.date) + 
    self.pork.to_i * Good.get_price(:pork, self.date) + 
    self.turkey.to_i * Good.get_price(:turkey, self.date) +
    self.other.to_f
  end
end
