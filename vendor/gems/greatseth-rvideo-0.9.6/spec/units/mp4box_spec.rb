require File.dirname(__FILE__) + '/../spec_helper'

module RVideo
  module Tools
  
    describe Mp4box do
      before do
        setup_mp4box_spec
      end
      
      it "should initialize with valid arguments" do
        @mp4box.class.should == Mp4box
      end
      
      it "should have the correct tool_command" do
        @mp4box.tool_command.should == 'MP4Box'
      end
            
      it "should mixin AbstractTool" do
        Mp4box.included_modules.include?(AbstractTool::InstanceMethods).should be_true
      end
      
      it "should set supported options successfully" do
        @mp4box.options[:output_file].should == @options[:output_file]
      end
    end
  end
end

def setup_mp4box_spec
  @options = {:output_file => "foo"}
  @command = "MP4Box $output_file$ -ipod"
  @mp4box = RVideo::Tools::Mp4box.new(@command, @options)
end