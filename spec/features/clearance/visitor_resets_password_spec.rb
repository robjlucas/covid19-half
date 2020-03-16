require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "Visitor resets password" do
  before { ActionMailer::Base.deliveries.clear }

  around do |example|
    original_adapter = ActiveJob::Base.queue_adapter
    ActiveJob::Base.queue_adapter = :inline
    example.run
    ActiveJob::Base.queue_adapter = original_adapter
  end

  scenario "by navigating to the page" do
    visit sign_in_path

    click_link "Forgot your password?"

    expect(current_path).to eq new_password_path
  end

  scenario "with valid email" do
    user = user_with_reset_password

    expect_page_to_display_change_password_message
    expect_reset_notification_to_be_sent_to user
  end

  scenario "with non-user user" do
    reset_password_for "unknown.email@example.com"

    expect_page_to_display_change_password_message
    expect_mailer_to_have_no_deliveries
  end

  scenario "with no email" do
    visit sign_in_path
    click_link "Forgot your password?"

    fill_in "Email", with: ""
    click_button "Reset password"

    expect(page).to have_content("Email can't be blank.")
  end

  private

  def expect_reset_notification_to_be_sent_to(user)
    expect(user.confirmation_token).not_to be_blank
    expect_mailer_to_have_delivery(
      user.email,
      "password",
      user.confirmation_token
    )
  end

  def expect_page_to_display_change_password_message
    expect(page).to have_content "You will receive an email within the next few minutes. It contains instructions for changing your password."
  end

  def expect_mailer_to_have_delivery(recipient, subject, body)
    expect(ActionMailer::Base.deliveries).not_to be_empty

    message = ActionMailer::Base.deliveries.any? do |email|
      email.to == [recipient] &&
        email.subject =~ /#{subject}/i &&
        email.html_part.body =~ /#{body}/ &&
        email.text_part.body =~ /#{body}/
    end

    expect(message).to be
  end

  def expect_mailer_to_have_no_deliveries
    expect(ActionMailer::Base.deliveries).to be_empty
  end
end
