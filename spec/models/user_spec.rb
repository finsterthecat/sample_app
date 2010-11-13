require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => 'Example user', :email => 'user@example.com'}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should reject long names" do
    long_name_user = User.new(@attr.merge(:name => "a"*51))
    long_name_user.should_not be_valid
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email" do
    no_name_user = User.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
  end

  it "should reject badly formed email" do
    bad_email_user = User.new(@attr.merge(:email => "xxx@yyy"))
    bad_email_user.should_not be_valid
  end

  it "should reject duplicate users" do
    user = User.create!(@attr)
    user_w_duplicate_email = User.new(@attr)
    user_w_duplicate_email.should_not be_valid
  end

  it "should reject duplicate users without regard to case" do
    user = User.create!(@attr)
    user_w_duplicate_email = User.new(@attr.merge(:email => @attr[:email].upcase))
    user_w_duplicate_email.should_not be_valid
  end
end
