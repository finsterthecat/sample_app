require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a Sign up page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => 'About')
    click_link "Help"
    response.should have_selector('title', :content => 'Help')
    click_link "Contact"
    response.should have_selector('title', :content => 'Contact')
    click_link "Home"
    response.should have_selector('title', :content => 'Home')
    click_link "Sign up now!"
    response.should have_selector('title', :content => 'Sign up')
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                    :content => "Sign in")
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector(
        "a", :href => signout_path,
        :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector(
        "a", :href => user_path(@user),
        :content => "Profile")
    end

  end

  # Ultimately this will test that admin users get delete options
  # while others do not
  describe "when signed in as admin" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "should show a delete link on user page" do
      visit users_path
      response.body.should have_selector('title', :content => 'All users')
      #Not sure how to do this. Currently not finding shit...
      response.should have_selector(
        "a", 
        :href => "/users/1",
        :'data-confirm' => "You sure?",
        :'data-method' => "delete",
        :rel => "nofollow",
        :title => "Delete Tony Brouwer",
        :content => "delete")

    end
  end

end


