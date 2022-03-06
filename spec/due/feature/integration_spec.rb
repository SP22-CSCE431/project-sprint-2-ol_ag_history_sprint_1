# frozen_string_literal: true

# location: spec/feature/integration_spec.rb
require 'rails_helper'

# OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
#   :provider => 'twitter',
#   :uid => '123545'
#   # etc.
# })

# before do
#   Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
#   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
# end

OmniAuth.config.silence_get_warning = true
RSpec.describe('Authentication', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    # visit new_admin_session_path click_on "Sign in with Google"
    visit admin_google_oauth2_omniauth_authorize_path
    # Permission.create!(description: 'admin') if Permission.where(description: 'admin').first.nil?
    # unless Admin.where(email: 'userdoe@example.com').first.nil? == false
    #   Admin.create!(email: 'userdoe@example.com', full_name: 'User Doe', uid: '123456789', avatar_url: 'https://lh3.googleusercontent.com/url/photo.jpg')
    # end
    Member.create!(fname: 'Admin', lname: 'Doe', email: 'admindoe@tamu.edu')
  end

  # Due Test

  describe 'paid', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")
      visit new_due_path
      select "John", :from => "due_member_id", match: :first
      select "Funeral", :from => "due_event_id", match: :first
      fill_in 'Amount',  with: 120
      check 'Paid'
      click_on "Submit"
      visit dues_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('120')
      # expect(page).to have_content('true')
    end
  end

  describe 'not paid', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")
      visit new_due_path
      select "John", :from => "due_member_id", match: :first
      select "Funeral", :from => "due_event_id", match: :first
      fill_in 'Amount',  with: 120
      click_on "Submit"
      visit dues_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('120')
      # expect(page).to have_content('false')
    end
  end
end