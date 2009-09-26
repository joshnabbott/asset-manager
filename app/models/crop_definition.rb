class CropDefinition < ActiveRecord::Base
  belongs_to :asset_category
  has_many :crops
  validates_presence_of :asset_category, :name, :minimum_width, :minimum_height, :x, :y
  validates_uniqueness_of :name, :scope => :asset_category_id

  # ActiveRecord attribute methods are defined dynamically so not defining the Object#name method results in
  # Object#name_with_asset_category_name failing because `name` hasn't yet been defined.
  def name
    self[:name]
  end

  # Method has a dependency on Object#name being defined when this class gets loaded. See description of `name` above.
  def name_with_asset_category_name
    [asset_category.name, name_without_asset_category_name].join('::')
  end
  alias_method_chain :name, :asset_category_name
end
