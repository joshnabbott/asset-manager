class VideoFormat < ActiveRecord::Base
  validates_presence_of :title, :description, :conversion_command
end
