# TODO: get_meta_data and santized_meta_data_for_yaml seem to be very out of place here.
class Image < Asset
  attr_accessor :image_ids
  has_attached_file :file, :url => "/system/images/:attachment/:id/:style/:filename"
  before_file_post_process :set_data_columns
  serialize :meta_data

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /image/

protected
  def get_meta_data(file_path)
    data = Paperclip.run("identify", %Q[-verbose "#{file_path}"[0]])

    begin
      YAML::load(sanitized_meta_data_for_yaml(data))
    rescue Exception => e
      logger.debug("Error raised while trying to read #{data} as YAML:\r\n#{e.inspect}")
    end
  end

  def sanitized_meta_data_for_yaml(data)
    data = data.gsub("\n\n", "\n")
    data = data.gsub(/\n\s{2}/, "\r\n")
  end

  def set_data_columns
    file_path         = self.file.queued_for_write[:original].path
    image             = Paperclip::Geometry.from_file(file_path)
    self.height       = image.try(:height)
    self.width        = image.try(:width)
    self.aspect_ratio = image.try(:aspect)
    self.meta_data    = self.get_meta_data(file_path)
  end
end