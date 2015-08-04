class Child < ActiveRecord::Base
  belongs_to :tent
  has_one :child_account
  has_many :child_consumptions

  validates_presence_of :first_name, :last_name


  default_scope { order :number }
  
  def account
    self.child_account || ChildAccount.create(child: self, name: self.full_name)
  end
  
  def full_name
    first_name + ' ' + last_name
  end

  def full_name_with_number
    "[#{number}] #{full_name}"
  end

  def nice_number
    "[#{number}]"
  end
  
  def account_balance
    self.account.balance - self.child_consumptions.map {|sc| sc.total }.sum
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end
end
