class ChildConsumption < ActiveRecord::Base
  belongs_to :child
  validates_uniqueness_of :child_id, :scope => [:date, :time_of_day]
  
  def other=(amount)
    if not amount.class == Float
      amount.gsub!(',', '.')
    end
    write_attribute(:other, amount)
  end

  def total
    self.soft_drink.to_i * Good.get_price(:soft_drink, self.date) + 
    self.other.to_f
  end
end
