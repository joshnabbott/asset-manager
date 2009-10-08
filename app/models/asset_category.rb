class AssetCategory < ActiveRecord::Base
  has_and_belongs_to_many :assets
  # has_and_belongs_to_many :images, :association_foreign_key => :asset_id, :join_table => 'asset_categories_assets'
  has_many :crop_definitions, :dependent => :destroy
end
