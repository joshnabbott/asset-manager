class Audio < Asset
  attr_accessor :audio_ids
  has_attached_file :file, :url => "/system/audio/:attachment/:id/:style/:filename"
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => "audio/mpeg"
  
  # Embed tag for easy use
  def embed(id="audioclip", width=250)
  	"<embed src=\"#{self.file.url}\" height=\"16\" width=\"#{width}\" type=\"audio/quicktime\" autoplay=\"false\" pluginspage=\"http://www.apple.com/quicktime/download\" enablejavascript=\"true\" id=\"#{id}\" />"
  end
  
  def extensions
    ext = []
    ext.push "mp3"
    return ext.uniq
  end
  
end
