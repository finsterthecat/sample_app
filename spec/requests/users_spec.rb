require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",                         :with => ""
          fill_in "Email",                        :with => ""
          fill_in "Password",                     :with => ""
          fill_in "Password Confirmation",        :with => ""
          click_button
          response.should render_template("users/new")
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end

    end

    describe "success" do
      it "should make a new user" do

        lambda do
          visit signup_path
          fill_in "Name",                         :with => "Example User"
          fill_in "Email",                        :with => "user@example.com"
          fill_in "Password",                     :with => "foobar"
          fill_in "Password Confirmation",        :with => "foobar"
          click_button
          response.should render_template("users/show")
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
        end.should change(User, :count).by(1)
      end
    end

  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        integration_sign_in(User.new(:email => "", :password => ""))
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        integration_sign_in(Factory(:user))
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

  describe "users list " do
    describe "for admin" do
      before(:each) do
        @user = Factory(:admin_user)
        integration_sign_in(@user)
      end

      it "should show a delete link for user" do
        visit users_path
        response.should have_selector('title', :content => 'All users')
        response.body.should have_selector(
          "a",
          :'data-method' => "delete",
          :content => 'delete')
      end
    end

    describe "for non-admin" do
      before(:each) do
        @user = Factory(:user)
        integration_sign_in(@user)
      end

      it "should not show a delete link for user" do
        visit users_path
        response.should have_selector('title', :content => 'All users')
        response.body.should_not have_selector(
          "a",
          :'data-method' => "delete",
          :content => 'delete')
      end
    end 
  end
end
