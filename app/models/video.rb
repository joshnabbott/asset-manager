require 'rvideo'

class Video < Asset
  has_attached_file :file, :url => "/system/videos/:attachment/:id/:style/:filename"
  has_attached_file :preview, :url => "/system/videos/:attachment/:id/:style/:filename", :styles => {:icon => "100x100#", :master => "500x500>"}
  validates_presence_of :title
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /video/
  
  before_file_post_process :create_preview
  
  def create_preview(milliseconds=2000)
    frame = RVideo::FrameCapturer.capture! :input => "#{self.file.queued_for_write[:original].path}", :offset => "#{(milliseconds/1000).to_s}"
    self.preview = File.open(frame[0], 'r')
    self.height = Paperclip::Geometry.from_file(self.preview.queued_for_write[:original].path).try(:height)
    self.width = Paperclip::Geometry.from_file(self.preview.queued_for_write[:original].path).try(:width)
  end
end