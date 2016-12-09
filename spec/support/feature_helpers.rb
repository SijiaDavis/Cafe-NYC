module FeatureHelpers
  def sign_in
    @user = FactoryGirl.create(:user)
    visit "/"
    click_link "Sign in"
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Log in"
  end
  
  def fill_out_new_cafe_form
    visit "/places/new"
    fill_in "place_name", :with => "Cafe Lingo"
    fill_in "place_description", :with => "Where the cool kids are."
    fill_in "place_address", :with => "68 Jay Street, Suite 720, Brooklyn 11201"  
  end
  
  def ajax_validation
    find('#place_address').native.send_keys(:tab)
    wait_for_ajax
  end
end
