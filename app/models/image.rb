class Image < Asset
  has_attached_file :file
  delegate :aspect_ratio, :exif_data, :height, :size, :width, :to => :file
end

# Paperclip Extensions to Attachment
class Paperclip::Attachment
  attr_reader :height, :width

  def aspect_ratio
    @aspect_ratio ||= Paperclip::Geometry.from_file(self.path).aspect
  end

  def exif_data
    @exif_data ||= get_exif_data
  end

  def height
    @height ||= Paperclip::Geometry.from_file(self.path).height
  end

  def width
    @width ||= Paperclip::Geometry.from_file(self.path).width
  end

  protected
    def convert_exif_data_to_hash(exif_data)
      exif_data = exif_data.split("\n")
      exif_data.inject({}) do |hash, array_element|
        # "exif:ApertureValue=0/1", "exif:ColorSpace=1"
        array_element.gsub!('exif:','')
        hash_key, hash_value = array_element.split('=')
        hash[hash_key] = hash_value
        hash
      end
    end

    def get_exif_data
      data = `identify -format '%[EXIF:*]' #{self.path}`
      data = convert_exif_data_to_hash(data)
    end
end