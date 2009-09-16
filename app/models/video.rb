require 'rvideo'

class Video < Asset
  has_attached_file :file, :url => "/system/videos/:attachment/:id/:style/:filename"
  has_attached_file :preview, :url => "/system/videos/:attachment/:id/:style/:filename", :styles => {:icon => "100x100#", :master => "500x500>"}
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /video/
  
  before_file_post_process :create_preview
  
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
  
  # Create easy hooks for rvideo data, go go gadget method_missing
  def method_missing(m, *args, &block)
    inspected = RVideo::Inspector.new(:file => self.file.path)
    if inspected.respond_to?(m)
      inspected.send(m, *args, &block)
    else
      super
    end
  end

end