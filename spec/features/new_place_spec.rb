require "rails_helper"

RSpec.feature "New place", :type => :feature do
  scenario "User types in a new place", :js => true do
    sign_in
    fill_out_new_cafe_form
    ajax_validation
    expect(page).to have_no_content('You already wrote about this place.')
  end
  
  scenario "User types in an existing place", :js => true do
    sign_in
    fill_out_new_cafe_form
    click_button "Create"
    fill_out_new_cafe_form
    ajax_validation
    expect(page).to have_content('You already wrote about this place.')
  end
  
  scenario "Another user types in an exisiting place created by some other user", :js => true do
    sign_in
    fill_out_new_cafe_form  
    ajax_validation
    expect(page).to have_no_content('You already wrote about this place.')
  end
end