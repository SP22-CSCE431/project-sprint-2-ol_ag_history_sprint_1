# frozen_string_literal: true

# location: spec/feature/integration_spec.rb
require 'rails_helper'

#NOTE: Due to some error the tests work when the members folder is called but not when the rspec spec/
# is called, this seems to be a problem with rspec or the order in which the tests are run

OmniAuth.config.silence_get_warning = true
RSpec.describe('Authentication', type: :feature) do
  before do
    Member.create!(fname: 'Admin', lname: 'Doe', email: 'admindoe@tamu.edu',  admin: 1)
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    # visit new_admin_session_path click_on "Sign in with Google"
    visit admin_google_oauth2_omniauth_authorize_path
    # Permission.create!(description: 'admin') if Permission.where(description: 'admin').first.nil?
    # unless Admin.where(email: 'userdoe@example.com').first.nil? == false
    #   Admin.create!(email: 'userdoe@example.com', full_name: 'User Doe', uid: '123456789', avatar_url: 'https://lh3.googleusercontent.com/url/photo.jpg')
    # end
  end

  #Members Test
  describe 'Creating Min Requirements for Member', type: :feature do
    it 'valid inputs' do
      visit new_member_path
      fill_in 'First Name', with: 'John' 
      fill_in 'Last Name', with: 'Henry'
      fill_in 'Email Address', with: 'JH@gmail.com'
      click_on 'Submit'
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JH@gmail.com')
    end
  end

  describe 'Creating Full Member', type: :feature do
    it 'valid inputs' do
      visit new_member_path
      fill_in 'First Name',  with: 'John' 
      fill_in 'Last Name',	with: 'Henry'
      fill_in 'Email Address',  with: 'JH@gmail.com'
      fill_in 'Join Date',  with: '01/01/2001'
      fill_in 'Graduation Date',  with: '01/01/2010'
      fill_in 'City',  with: 'Austin'
      check "Admin"
      fill_in 'Major',  with: 'CS Major'
      click_on 'Submit'
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JH@gmail.com')
      expect(page).to have_content('2001-01-01')
      expect(page).to have_content('2010-01-01')
      expect(page).to have_content('Austin')
      expect(page).to have_content('false')
      expect(page).to have_content('CS Major')
      expect(page).to have_content('true')
    end
  end

  describe 'Creating Edit Full Member', type: :feature do
    it 'valid inputs' do
      test_member = Member.create!(fname: 'John', lname: 'Henry', joinDate: '01/01/2001', gradDate: "01/01/2010", email: "JH@gmail.com", city: "Austin", admin: 0, major: "CS Major", active: 1)
      visit edit_member_path(id: test_member.id)
      fill_in 'Last Name', with: 'Smith'
      fill_in 'City', with: 'Dallas'
      click_on 'Submit'
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Smith')
      expect(page).to have_content('JH@gmail.com')
      expect(page).to have_content('2001-01-01')
      expect(page).to have_content('2010-01-01')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('CS Major')
      expect(page).to have_content('true')
      expect(page).to have_content('false')
    end
  end

  describe 'Delete Member', type: :feature do
    it 'valid inputs' do
      Member.destroy_all
      Member.create!(fname: 'Admin', lname: 'Doe', email: 'admindoe@tamu.edu',  admin: 1)
      test_member = Member.create!(fname: 'Victor', lname: 'Henry', joinDate: '01/01/2001', gradDate: "01/01/2010", email: "JH@gmail.com", city: "Austin", admin: 1, major: "CS Major", active: 1)
      visit members_path
      expect(page).to have_content('Victor')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JH@gmail.com')
      expect(page).to have_content('2001-01-01')
      expect(page).to have_content('2010-01-01')
      expect(page).to have_content('Austin')
      expect(page).to have_content('true')
      expect(page).to have_content('CS Major')
      expect(page).to have_content('true')
      click_on 'Destroy', match: :first

      begin
        page.driver.browser.switch_to.alert.accept
      rescue StandardError
        Selenium::WebDriver::Error::NoSuchAlertError
      end

      expect(page).not_to have_content('Victor')
    end
  end
end
