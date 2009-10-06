class Crop < ActiveRecord::Base
  # Sets the default size to scale to when cropping an image.
  DEFAULT_IMAGE_SCALE = '25'
  belongs_to :image
  belongs_to :crop_definition
end