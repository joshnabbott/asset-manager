# FIXME: Documentation needs to be updated to reflect that :size is now :width, :height and :from is now :x, :y
module AssetsHelper
  require 'md5'
  class CropNotFoundError < StandardError; end

  # USAGE:
  # <%= @image = Image.first %>
  # SIMPLE:
  # <%= asset_tag(@image) %>
  # Will return an img tag with @image, sized at max 400px wide or height, depending on which is greater.
  # Possible options are:
  # +crop+ - Passes the name of a crop. Crops may have identical names across asset categories. You can specify a crop within
  # an asset category, you can pass the asset category name and crop name in this format: 'Asset Category Name::Crop Name'.
  # If you do have crops named alike across asset categories, but don't specify the asset category name, the first crop found
  # matching that name is returned.
  #
  # +size+ - In the format of either '100x0' or '100x100'. Setting both width and height will return an image resized to the widthxheight.
  # Size is a required parameter, unless +crop+ is passed (as the crop will define the +size+ and +from+ parameters.). NOTE: Passing only
  # +size+ will simply resize the image, not crop it. For a cropped version of the image at that size, pass in the +from+ option.
  #
  # +from+ - Sets the x, y values to offset the crop. Pass it in similar to the +size+ option: 100x100.
  # EXAMPLE:
  # <%= asset_tag(@image, :size => '250x250', :from => '25x25') %>
  # Will return an image cropped 25 pixels from the top left, at the exact size specified.
  #
  # +resize_to+ - The image can be resized after being cropped to specific dimenions with this option. Passed in the same format as +size+.
  # EXAMPLE:
  # <%= asset_tag(@image, :size => '250x250', :from => '25x25', :resize_to => '100x100') %>
  # Will return an image cropped at the offset specified by +from+ at the size of +size+, but then resized (not cropped) to +resize_to+
  #
  # +exact+ - This option only applies when specifying +resize_to+. Passed as true, or false. If exact is true, the image will
  # cropped to +size+, but then resized to +resize_to+ and then padded on either size, top or bottom, to make the image dimensions
  # exactly match +resize_to+.
  # EXAMPLE:
  # <%= asset_tag(@image, :size => '250x250', :from => '25x25', :resize_to => '100x100', :exact => true) %>
  # Will return an image cropped at the offset specified by +from+ at the size of +size+, resized (not cropped) to +resize_to+
  # and then padded where needed to make the exact dimensions of +resize_to+.
  def build_options_for_asset_tag(asset, options={})
    raise "You must pass an asset into asset_tag." unless asset
    options.reverse_merge!(default_options_for_asset_tag)
    options.reverse_merge!(:alt => asset.file_file_name)

    crop_name = options.delete(:crop)

    if crop_name
      crop_definition = find_crop_definition_by_name(crop_name)
      raise ActiveRecord::RecordNotFound, "Crop Definition does not exist: #{crop_name}" unless crop_definition

      crop = Crop.find(:first, :conditions => { :image_id => asset.id, :crop_definition_id => crop_definition.id })
      options.update(options_for_image(crop || crop_definition))
    end

    background_color = options.delete(:background_color)
    exact            = options.delete(:exact)
    format           = options.delete(:format)
    height           = options.delete(:height)
    position         = options.delete(:position)
    resize_to        = options.delete(:resize_to)
    width            = options.delete(:width)
    x                = options.delete(:x)
    y                = options.delete(:y)
    name             = MD5.hexdigest(options.to_s)

    options.merge!(:asset_options => {:name => name, :x => x, :y => y, :width => width, :height => height, :resize_to => resize_to, :exact => exact, :format => format, :position => position, :background_color => background_color})
  end

  def asset_path(asset, options = {})
    options = build_options_for_asset_tag(asset, options).delete(:asset_options)
    cropped_image_path(asset, options)
  end

  def asset_tag(asset, options = {})
    options       = build_options_for_asset_tag(asset, options)
    asset_options = options.delete(:asset_options)
    image_tag(asset_path(asset, asset_options), options)
  end

private
  def default_options_for_asset_tag
    {
      :exact            => false,
      :x                => 0,
      :y                => 0,
      :resize_to        => nil,
      :format           => 'png',
      :position         => 'center',
      :background_color => 'none'
    }
  end

  def find_crop_definition_by_name(name)
    crop_definition = if name =~ /::/
      parts = name.split('::')
      asset_category = AssetCategory.find_by_name(parts.first)
      raise ActiveRecord::RecordNotFound, "You specified an asset category of #{parts.first} (#{name}), but there is no AssetCategory by that name." unless asset_category
      asset_category.crop_definitions.find_by_name(parts.last)
    else
      CropDefinition.find_by_name(name)
    end
  end

  def options_for_image(crop_or_crop_definition)
    {
      :x      => crop_or_crop_definition.x1,
      :y      => crop_or_crop_definition.y1,
      :width  => crop_or_crop_definition.width,
      :height => crop_or_crop_definition.height
    }
  end
end