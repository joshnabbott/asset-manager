require File.dirname(__FILE__) + '/../lib/rvideo'

# Because rspec's assertion style is a stupid, giant 
# fucking waste of time. It's true!
require 'spec/interop/test'
require File.dirname(__FILE__) + "/support"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# NOTE some expectations in these specs may rely on behavior            #
# not present in your local build of ffmpeg.                            #
#                                                                       #
# Any work on supporting multiple builds packaged with the tests        #
# would be accepted, but ffmpeg itself does not support old versions    #
# so it might be best to upgrade if you want to rely on the accuracy of #
# these tests.                                                          #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
