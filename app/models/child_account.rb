class ChildAccount < ActiveRecord::Base
  belongs_to :child
  acts_as :account
end
