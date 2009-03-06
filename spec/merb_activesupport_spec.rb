require File.dirname(__FILE__) + '/spec_helper'

describe "merb_activesupport" do

  before(:all) do
    Merb::Plugins.config[:merb_activesupport][:only] = [:try, :array_access]
    require "merb_activesupport"
  end

  it "defines only specified methods" do
    [ 1, 2 ].should be_respond_to(:second)
    nil.should be_respond_to(:try)
    nil.should_not be_respond_to(:present?)
  end

end
