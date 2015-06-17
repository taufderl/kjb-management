class ChildrenAccount < ActiveRecord::Base
  belongs_to :children
    acts_as :account
end
