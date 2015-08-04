class ScoutAccount < ActiveRecord::Base
  belongs_to :scout
  acts_as :account
  validates_presence_of :scout
end
