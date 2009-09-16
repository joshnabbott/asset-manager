###

FIXTURE_PATH   = File.expand_path(File.dirname(__FILE__) + '/../spec/fixtures')

LOG_PATH = File.join(File.dirname(__FILE__), "spec.log")
RVideo.logger = Logger.new LOG_PATH

###

def ffmpeg(key)
  load_fixture(:ffmpeg_builds)[key.to_s]['response']
end

def files(key)
  load_fixture(:files)[key.to_s]['response']
end

def recipes(key)
  load_fixture(:recipes)[key.to_s]
end

# The strip in here is important as the result parsing is apparently 
# quite fussy about leading or trailing whitespace.
def ffmpeg_result(key)
  load_fixture(:ffmpeg_results)[key.to_s].strip
end

###

def load_fixture(name)
  YAML.load_file("#{FIXTURE_PATH}/#{name}.yml")
end

def spec_file(name)
  File.expand_path File.join(File.dirname(__FILE__), "files", name)
end
