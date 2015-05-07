class Child < ActiveRecord::Base
  belongs_to :tent
  def name
    first_name + ' ' + last_name
  end
end
