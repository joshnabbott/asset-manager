class Image < Asset
  has_attached_file :file
  after_save :update_data_columns
  serialize :file_meta_data

protected
  def get_meta_data
    data = identify(self.file.path, '-verbose')

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

  def update_data_columns
    self.aspect_ratio = Paperclip::Geometry.from_file(self.file.path).try(:aspect)
    self.height       = Paperclip::Geometry.from_file(self.file.path).try(:height)
    self.meta_data    = self.get_meta_data
    self.width        = Paperclip::Geometry.from_file(self.file.path).try(:width)
    self.send(:update_without_callbacks)
  end
end