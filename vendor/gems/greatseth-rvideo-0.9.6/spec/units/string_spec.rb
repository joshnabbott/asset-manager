require File.dirname(__FILE__) + "/../spec_helper"

describe String, "shell quoting" do
  it "should wrap self in single quotes" do
    "foo".shell_quoted.should == "'foo'"
    "foo & bar $(rm -rf /)".shell_quoted.should == "'foo & bar $(rm -rf /)'"
  end
end
