class VideoFormat < ActiveRecord::Base
  validates_presence_of :title, :description, :conversion_command, :output_file_extension
  has_many :encoded_videos
end
