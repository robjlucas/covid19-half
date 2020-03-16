require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "Visitor signs in" do
  scenario "with valid email and password" do
    create_user "user@example.com", "password"
    sign_in_with "user@example.com", "password"

    expect_user_to_be_signed_in
  end

  scenario "with valid mixed-case email and password " do
    create_user "user.name@example.com", "password"
    sign_in_with "User.Name@example.com", "password"

    expect_user_to_be_signed_in
  end

  scenario "tries with invalid password" do
    create_user "user@example.com", "password"
    sign_in_with "user@example.com", "wrong_password"

    expect_page_to_display_sign_in_error
    expect_user_to_be_signed_out
  end

  scenario "tries with invalid email" do
    sign_in_with "unknown.email@example.com", "password"

    expect_page_to_display_sign_in_error
    expect_user_to_be_signed_out
  end

  scenario "tries without password or email", :run_jobs do
    sign_in_with "", ""

    expect(page).to have_text("Bad email or password.")
    expect_user_to_be_signed_out
  end

  private

  def create_user(email, password)
    FactoryBot.create(:user, email: email, password: password)
  end

  def expect_page_to_display_sign_in_error
    expect(page).to have_text("Bad email or password.")
  end

  def expect_page_to_display_reset_password_alert
    expect(page).to have_text("You have not set a password")
  end

  def expect_reset_password_email_to_be_sent
    deliveries = ActionMailer::Base.deliveries
    expect(deliveries).to_not be_empty
    expect(deliveries.first.subject).to eq("Set your password")
  end
end
