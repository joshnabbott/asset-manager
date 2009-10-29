module CropsHelper
  def default_image_scale
    '25'
  end

  def resize_to(image_width)
    image_width * ((params[:scale] || default_image_scale).to_f / 100)
  end
end