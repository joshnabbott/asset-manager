require File.dirname(__FILE__) + '/../spec_helper'

module RVideo
  describe "The entire system should work together" do
    it "with kites.mp4" do
      output_file = "#{TEMP_PATH}/kites.flv"
      FileUtils.rm_f(output_file)
      FileTest.exist?(output_file).should_not be_true
      transcoder = Transcoder.new(spec_file("kites.mp4"))
      transcoder.original.class.should == Inspector
      transcoder.original.duration.should == 19600
      transcoder.execute(recipes('flash_300')['command'], {:output_file => output_file})
      FileTest.exist?(output_file).should be_true
    end

    # it "with The Michael Scott Story" do
    #   file = 'michael_scott_story.mov'
    #   output_file = "#{TEMP_PATH}/#{file}.flv"
    #   FileUtils.rm_f(output_file)
    #   FileTest.exist?(output_file).should_not be_true
    #   transcoder = Transcoder.new("#{TEST_FILE_PATH}/#{file}")
    #   transcoder.original.class.should == Inspector
    #   transcoder.original.duration.should == 30400
    #   transcoder.execute(recipes('one_pass')['command'], {:output_file => output_file})
    #   FileTest.exist?(output_file).should be_true
    # end

  end
end