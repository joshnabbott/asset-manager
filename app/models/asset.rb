class Asset < ActiveRecord::Base
  belongs_to :owner
  acts_as_taggable_on :tags
end