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

  describe "from_users_followed_by" do

    before(:each) do
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))

      @user_post = @user.microposts.create!(:content=> "foo!")
      @other_user_post = @other_user.microposts.create!(:content=> "bar!")
      @third_user_post = @third_user.microposts.create!(:content=> "baz!")

      @user.follow!(@other_user)
    end

    it "should have a from_users_followed_by" do
      Micropost.should respond_to(:from_users_followed_by)
    end

    it "should include the followed user's microposts" do
      Micropost.from_users_followed_by(@user).should include(@other_user_post)
    end

    it "should include the user's own micropoists" do
      Micropost.from_users_followed_by(@user).should include(@user_post)
    end

    it "should not include the third user's microposts" do
      Micropost.from_users_followed_by(@user).should_not include(@third_user_post)
    end

  end


end
