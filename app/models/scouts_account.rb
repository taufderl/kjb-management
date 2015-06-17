class ScoutsAccount < ActiveRecord::Base
  belongs_to :scouts
    acts_as :account
end
