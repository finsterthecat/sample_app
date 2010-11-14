require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => 'Example user',
      :email => 'user@example.com',
      :password => "foobar",
      :password_confirmation => "foobar"}
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

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password validation" do
      User.new(@attr.merge(:password_confirmation => "barfoo")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" *5
      User.new(@attr.merge(:password => short, :password_validation => short)).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      User.new(@attr.merge(:password => long, :password_validation => long)).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if passwords don't match" do
        @user.has_password?("badpassword").should be_false
      end

    end

    describe "authenticate method" do
      it "should return null on email/password mismatch" do
        User.authenticate(@attr[:email], 'badpass').should be_nil
      end

      it "should return nil for email for no user" do
        User.authenticate('badname@bademai.com', @attr[:password]).should be_nil
      end

      it "should return the user on email/password match" do
        @user.should == User.authenticate(@attr[:email], @attr[:password])
      end

    end

  end

end
