class Disbursement < ActiveRecord::Base
  belongs_to :accounts
  belongs_to :user
end
