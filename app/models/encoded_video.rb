class EncodedVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :video_format
  
  validates_presence_of :video_id
  validates_presence_of :video_format_id
end
