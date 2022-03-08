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
    Member.create!(fname: 'Admin', lname: 'Doe', email: 'admindoe@tamu.edu', admin: 1)
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    visit admin_google_oauth2_omniauth_authorize_path
    # Permission.create!(description: 'admin') if Permission.where(description: 'admin').first.nil?
    # unless Admin.where(email: 'userdoe@example.com').first.nil? == false
    #   Admin.create!(email: 'userdoe@example.com', full_name: 'User Doe', uid: '123456789', avatar_url: 'https://lh3.googleusercontent.com/url/photo.jpg')
    # end
  end

  # Attendance Test

  describe 'rsvped and attended', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com", admin: 1)
      testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")
      visit new_attendance_path
      expect(page).to have_content('fesfesesfafesefaesfseafeff')
      select "John", :from => "attendance_member_id", match: :first
      select "Funeral", :from => "attendance_event_id", match: :first
      check 'Rsvp'
      check 'Attended'
      click_on "Submit"
      visit attendances_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('true')
      expect(page).to have_content('true')
    end
  end

  describe 'no rsvp and attended', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com", admin: 1 )
      testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")
      visit new_attendance_path
      select "John", :from => "attendance_member_id", match: :first
      select "Funeral", :from => "attendance_event_id", match: :first
      check 'Attended'
      click_on "Submit"
      visit attendances_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('false')
      expect(page).to have_content('true')
    end
  end

  describe 'Member Name link', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com", admin: 1)
      testMember2 = Member.create!(fname: "Jane", lname: "Doe", email: "JaneDoe@email.com", admin: 1)
      testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")
      testEvent2 = Event.create!(name: "Party", location: "MSC", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")
      visit new_attendance_path
      select "John", :from => "attendance_member_id", match: :first
      select "Funeral", :from => "attendance_event_id", match: :first
      check 'Rsvp'
      check 'Attended'
      click_on "Submit"
      visit attendances_path
      visit new_attendance_path
      select "Jane", :from => "attendance_member_id", match: :first
      select "Party", :from => "attendance_event_id", match: :first
      check 'Rsvp'
      check 'Attended'
      click_on "Submit"
      visit attendances_path
      # click_link "Member Name"
      expect(page).to have_content('John')
      expect(page).to have_content('Jane')
    end
  end

end
