class Good < ActiveRecord::Base
  self.inheritance_column = nil

  validates_presence_of :type, :price, :date
  
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

  def price=(amount)
    if not amount.class == Float
      amount.gsub!(',', '.')
    end
    write_attribute(:price, amount)
  end

  
  def self.get_price(type, date)
    pricetag = Good.where("type = ? AND date <= ?", type, date.to_date).order(date: "DESC").first
    if not pricetag
      # if no pricetag found that has been set before the current date use the oldest one in the db
      pricetag = Good.where(type: type).order(date: "ASC").first
    end
    pricetag.price
  end
end
