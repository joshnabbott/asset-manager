# I don't know what this file was intended for originally, but I've been 
# using it to setup RVideo to play with in an IRB session. - Seth

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))
require "lib/rvideo"
require "spec/support"

include RVideo

###

class Inspector
  public :video_match
  public :audio_match
end

def inspector(filename)
  options = if filename.is_a? Symbol
    { :raw_response => files(filename) }
  else
    { :file => spec_file(filename) }
  end
  
  Inspector.new options
end
