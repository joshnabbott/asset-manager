class AssetCategory < ActiveRecord::Base
  has_and_belongs_to_many :assets
  has_many :crop_definitions, :dependent => :destroy
end
