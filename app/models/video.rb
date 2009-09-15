require 'rvideo'

class Video < Asset
  has_attached_file :file, :url => "/system/videos/:attachment/:id/:style/:filename"
  has_attached_file :preview, :url => "/system/videos/:attachment/:id/:style/:filename"
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /video/
  
  before_file_post_process :create_preview
  
  def create_preview(milliseconds=2000)
    # Make sure that /usr/local/bin is always in the path. Had issues with Passenger in the past.
    ENV['PATH'] = '/usr/local/bin:' + ENV['PATH']
    frame = RVideo::FrameCapturer.capture! :input => "#{self.file.queued_for_write[:original].path}", :offset => "#{(milliseconds/1000).to_s}"
    self.preview = File.open(frame[0], 'r')
  end
end