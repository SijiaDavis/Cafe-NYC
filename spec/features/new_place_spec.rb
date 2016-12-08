require "rails_helper"

RSpec.feature "New place", :type => :feature do
  scenario "User types in a new place", :js => true do
    sign_in
    visit "/places/new"

    fill_in "place_name", :with => "Cafe Lingo"
    fill_in "place_description", :with => "Where the cool kids are."
    fill_in "place_address", :with => "68 Jay Street, Suite 720, Brooklyn 11201"
    
    #find('#place_address').native.send_keys(:tab)
    click_button "Create"

    expect(page).to have_no_content('You already wrote about this place.')
  end
end