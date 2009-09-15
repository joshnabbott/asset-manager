class Image < Asset
  has_attached_file :file
  after_save :update_additional_file_columns
  serialize :file_meta_data
  delegate :aspect_ratio, :height, :meta_data, :size, :width, :to => :file

protected
  def update_additional_file_columns
    self.file_aspect_ratio = self.file.aspect_ratio
    self.file_height       = self.file.height
    self.file_meta_data    = self.file.meta_data
    self.file_width        = self.file.width

    self.send(:update_without_callbacks)
  end
end

# Paperclip Extensions to Attachment
class Paperclip::Attachment
  def aspect_ratio
    @aspect_ratio ||= Paperclip::Geometry.from_file(self.path).try(:aspect)
  end

  def height
    @height ||= Paperclip::Geometry.from_file(self.path).try(:height)
  end

  # Returns a YAML representation of meta data returned by the `identify -verbose` command
  def meta_data
    @meta_data ||= get_meta_data
  end

  def width
    @width ||= Paperclip::Geometry.from_file(self.path).try(:width)
  end

  protected
    # def convert_meta_data_to_hash(meta_data)
    #   meta_data = meta_data.split("\n")
    #   meta_data.inject({}) do |hash, array_element|
    #     hash_key, hash_value = array_element.split(':').map(&:strip)
    #     hash[hash_key] = hash_value
    #     hash
    #   end
    # end

    # def get_meta_data
    #   data = `identify -verbose #{self.path}`
    #   data = convert_meta_data_to_yaml(data)
    # end

    def get_meta_data
      data = `identify -verbose #{self.path}`
      YAML::load(data.gsub(/\n\s{2}/, "\r\n"))
    end
end