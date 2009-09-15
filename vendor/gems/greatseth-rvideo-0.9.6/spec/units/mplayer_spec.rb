require File.dirname(__FILE__) + '/../spec_helper'

module RVideo
  module Tools
  
    describe Mplayer do
      before do
        setup_mplayer_spec
      end
      
      it "should initialize with valid arguments" do
        @mplayer.class.should == Mplayer
      end
      
      it "should have the correct tool_command" do
        @mplayer.tool_command.should == 'mplayer'
      end
            
      it "should mixin AbstractTool" do
        Mplayer.included_modules.include?(AbstractTool::InstanceMethods).should be_true
      end
      
      it "should set supported options successfully" do
        @mplayer.options[:output_file].should == @options[:output_file]
      end
    end
  end
end

def setup_mplayer_spec
  @options = {:output_file => "foo"}
  @command = "mplayer temp.avi -dumpaudio -dumpfile temp.aac"
  @mplayer = RVideo::Tools::Mplayer.new(@command, @options)
end