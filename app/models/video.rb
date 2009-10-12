require 'rvideo'

class Video < Asset
  attr_accessor :video_ids
  has_attached_file :file, :url => "/system/videos/:attachment/:id/:style/:filename"
  has_attached_file :preview, :url => "/system/videos/:attachment/:id/:style/:filename", :styles => {:icon => "100x100>", :edit => "200x200>", :master => "500x500>"}
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /video/
  has_many :encoded_videos, :dependent => :destroy
  
  before_file_post_process :create_preview
  
  # Create preview for the video
  def create_preview(milliseconds=2000)
    # Make sure we use the right file, self.file.path doesn't exist before a save
    # This method is public and can be called outside of before_file_post_process
    if self.file.queued_for_write[:original].present?
      current_file = self.file.queued_for_write[:original].path
    else 
      current_file = self.file.path(:original)
    end
    
    # Grab frame for preview
    frame = RVideo::FrameCapturer.capture! :input => "#{current_file}", :offset => "#{(milliseconds/1000).to_s}"
    
    # Set preview file for paperclip
    File.open(frame[0], 'r') do |f|
      self.preview = f
    end
    
    # Might as well set some meta data too. It's easier to get geometry from the image than the videeo.
    image = Paperclip::Geometry.from_file(frame[0])
    self.height = image.try(:height)
    self.width = image.try(:width)
    self.aspect_ratio = image.try(:aspect)
  end
  
  # Embed tag for easy use
  def embed(id="movie")
  	"<embed height=\"#{self.height + 16}\" width=\"#{self.width}\" src=\"#{self.file.url}\" type=\"video/quicktime\" autoplay=\"false\" pluginspage=\"http://www.apple.com/quicktime/download\" enablejavascript=\"true\" id=\"#{id}\" />"
  end
  
  # Get valid mime-type extensions
  def extensions
    mime_types = []
    MIME::Types[/^video/].each do |t|
      mime_types.push t
    end
    ext = []
    for mime_type in mime_types
      ext.concat mime_type.extensions
    end
    return ext.uniq
  end
  
  # Create easy hooks for rvideo data, go go gadget method_missing
  def method_missing(m, *args, &block)
    begin
      super
    rescue
      inspected = RVideo::Inspector.new(:file => self.file.path)
      if inspected.respond_to?(m)
        inspected.send(m, *args, &block)
      else
        super
      end
    end
  end

end