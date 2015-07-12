class Good < ActiveRecord::Base
  self.inheritance_column = nil
  
  def self.types
    [
      :beer,
      :soft_drink,
      :sausage,
      :pork,
      :turkey,
      :corn,
    ]
  end
  
  def self.get_price(type, date)
    pricetag = Good.where("type = ? AND date <= ?", type, date).order(date: "DESC").first
    pricetag.price
  end
end
