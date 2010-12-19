require 'spec_helper'

describe "friendly forwardings" do

  it "should forward to the requested page after sign in" do
    user = Factory(:user)
    visit edit_user_path(user)
    # The test automatically follows the redirect to the signin page
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
    # The test follows the redirect again this time to the users/edit
    response.should render_template('users/edit')
  end
end
