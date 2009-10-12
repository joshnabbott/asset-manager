class VideoFormat < ActiveRecord::Base
  validates_presence_of :title, :description, :conversion_command
  has_many :encoded_videos
end
