require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User updates account" do
  scenario "changes email and password" do
    sign_in
    click_on "Your account"

    within ".edit_user" do
      fill_in "Email", with: "wret@gqrsdag.org"
      fill_in "Password", with: "newpassword"
      click_on "Update account"
    end

    expect(page).to have_text "Account updated"
    expect(page).to have_field("Email", with: "wret@gqrsdag.org")
  end

  scenario "enters bad details" do
    sign_in
    click_on "Your account"

    within ".edit_user" do
      fill_in "Email", with: "waftcap"
      click_on "Update account"
    end

    expect(page).to have_text "Email is invalid"
  end
end
