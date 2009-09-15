require 'rvideo'

class Video < Asset
  has_attached_file :file
  has_attached_file :preview
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /video/
  
  def create_preview
    # Make sure that /usr/local/bin is always in the path.
    ENV['PATH'] = '/usr/local/bin:' + ENV['PATH']
    frame = RVideo::FrameCapturer.capture! :input => "#{self.file.path}", :offset => "#{(milliseconds/1000).to_s}"
  end
end