class Good < ActiveRecord::Base
  self.inheritance_column = nil
  
  def self.types
    [
      :beer,
      :soft_drink,
      :sausage,
      :pork,
      :turkey,
    ]
  end
  
  def self.get_price(type, date)
    # TODO: implement proper current price mechanism
    0.99
  end
end
