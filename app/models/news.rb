class News < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user, :comment
end
