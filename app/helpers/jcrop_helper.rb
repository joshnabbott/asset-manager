#TODO: this is currently working fine when an image has been scaled down to fit the browser window, but breaks when the image doesn't need to be scaled down.
module JcropHelper
  def jcrop_initializer(crop, options = {})
    options = jcrop_defaults.update(options)
    crop_definition = crop.crop_definition

    raise "Crop Definition must be defined to make a crop." unless crop_definition

    <<-CODE
      jQuery('#jcrop_target').Jcrop({
        aspectRatio: #{crop_definition.is_specific ? (crop_definition.minimum_width.to_f / crop_definition.minimum_height.to_f) : options[:aspect_ratio]},
        bgColor: '#{options[:bg_color]}',
        bgOpacity: #{options[:bg_opacity]},
        boxHeight: #{options[:box_height]},
        boxWidth: #{options[:box_width]},
        minSize: [#{crop_definition.minimum_width}, #{crop_definition.minimum_height}],
        onChange: setCropValues,
        setSelect: #{calculate_set_select(crop, options[:box_width])}
      });
    CODE
  end

private
  def aspect_ratio(width,height)
    width.to_f / height.to_f
  end

  def calculate_set_select(crop, box_width)
    # if @image.image_width > box_width
      "[#{crop.x} * ((#{box_width}) / #{@image.image_width}), #{crop.y} * ((#{box_width}) / #{@image.image_width}), #{crop.x + crop.width} * ((#{box_width}) / #{@image.image_width}), #{crop.y + crop.height} * ((#{box_width}) / #{@image.image_width})]"
    # else
    #   "[#{crop.x}, #{crop.y}, #{crop.x + crop.width}, #{crop.y + crop.height}]"
    # end
  end

  def jcrop_defaults
    {
      :aspect_ratio => 0,
      :bg_color => 'white',
      :bg_opacity => '.5',
      :box_height => 0,
      :box_width => 0,
      :select_size => '[100,100]',
      :min_size => '[0,0]'
    }
  end
end