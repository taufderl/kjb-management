class ChildAccount < ActiveRecord::Base
  belongs_to :child
  acts_as :account
  validates_presence_of :child
end
