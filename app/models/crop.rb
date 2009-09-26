class Crop < ActiveRecord::Base
  belongs_to :image
  belongs_to :crop_definition
end