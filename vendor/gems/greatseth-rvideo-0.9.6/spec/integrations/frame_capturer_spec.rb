require File.dirname(__FILE__) + '/../spec_helper'

module RVideo
  describe FrameCapturer do
    # TODO!
    # These are the old specs, too tired to fix 'em up at the moment..
    # 
    # it "should create a screenshot with a default output path" do
    #   output_file = "#{TEMP_PATH}/kites-10p.jpg"
    #   FileTest.exist?(output_file).should_not be_true
    #   file = Inspector.new(:file => spec_file("kites.mp4"))
    #   file.capture_frame("10%").should == output_file
    #   FileTest.exist?(output_file).should be_true
    #   FileUtils.rm_f(output_file)
    # end
    # 
    # it "should create a screenshot with a custom output path" do
    #   output_file = spec_file("kites-10p.jpg")
    #   FileTest.exist?(output_file).should be_false
    #   file = Inspector.new(:file => spec_file("kites.mp4"))
    #   file.capture_frame("10%", output_file).should == output_file
    #   FileTest.exist?(output_file).should be_true
    #   FileUtils.rm_f(output_file)
    # end
  end
end
