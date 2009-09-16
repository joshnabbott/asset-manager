require File.dirname(__FILE__) + '/../spec_helper'

module RVideo
  module Tools
  
    describe Mp4creator do
      before do
        setup_mp4creator_spec
      end
      
      it "should initialize with valid arguments" do
        @mp4creator.class.should == Mp4creator
      end
      
      it "should have the correct tool_command" do
        @mp4creator.tool_command.should == 'mp4creator'
      end
            
      it "should mixin AbstractTool" do
        Mp4creator.included_modules.include?(AbstractTool::InstanceMethods).should be_true
      end
      
      it "should set supported options successfully" do
        @mp4creator.options[:output_file].should == @options[:output_file]
      end
    end
  end
end

def setup_mp4creator_spec
  @options = {:output_file => "foo"}
  @command = "mp4creator -create=temp.aac $output_file$"
  @mp4creator = RVideo::Tools::Mp4creator.new(@command, @options)
end