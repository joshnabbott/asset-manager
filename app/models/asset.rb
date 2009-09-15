class Asset < ActiveRecord::Base
  belongs_to :owner
  validates_presence_of :title
end
