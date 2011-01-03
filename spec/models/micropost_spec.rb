require 'spec_helper'

describe Micropost do

  before (:each) do
    @user = Factory(:user)
    @attr = {:content => "vaue for content"}
  end

  it "should create a new instance given valid attribs" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do

    before (:each) do
      @micropost = @user.microposts.create!(@attr)
    end

    it "should have a user attrib" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end

  end

  describe "validations" do

    it "should require a userid" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require non-blank content" do
      @user.microposts.build(:content => "    ").should_not be_valid
    end

    it "should reject over-long content" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end

    it "should accept content of 140 chars" do
      @user.microposts.build(:content => "a" * 140).should be_valid
    end
  end
end
