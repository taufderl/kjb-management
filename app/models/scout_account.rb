class ScoutAccount < ActiveRecord::Base
  belongs_to :scout
  acts_as :account
end
