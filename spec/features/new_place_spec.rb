require "rails_helper"

RSpec.feature "New place", :type => :feature do
  scenario "User types in a new place" do
    user = FactoryGirl.create(:user)
    page.set_rack_session(user: user.id)
    
    visit "/places/new"

    fill_in "place_name", :with => "Cafe Lingo"
    fill_in "place_description", :with => "Where the cool kids are."
    fill_in "place_address", :with => "68 Jay Street, Suite 720, Brooklyn 11201"
    click_button "Create Widget"

    expect(page).to have_text("Widget was successfully created.")
  end
end