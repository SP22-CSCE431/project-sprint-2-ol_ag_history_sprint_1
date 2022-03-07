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
    # visit new_admin_session_path click_on "Sign in with Google"
    visit admin_google_oauth2_omniauth_authorize_path
    # Permission.create!(description: 'admin') if Permission.where(description: 'admin').first.nil?
    # unless Admin.where(email: 'userdoe@example.com').first.nil? == false
    #   Admin.create!(email: 'userdoe@example.com', full_name: 'User Doe', uid: '123456789', avatar_url: 'https://lh3.googleusercontent.com/url/photo.jpg')
    # end
  end

  # Lineage

  describe 'Lineage one null node', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com', admin: 1)
      testMember2 = Member.create!(fname: 'Tim', lname: 'Henry', email: 'JohnHenry@email.com', admin: 1)

      visit new_lineage_path
      select 'John', :from => 'lineage_member_id', match: :first
      select 'Tim', :from => 'lineage_father', match: :first
      select 'None', :from => 'lineage_son', match: :first
      click_on 'Submit'
      visit lineages_path

      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
    end
  end

  describe 'Lineage three diffrent member nodes', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember2 = Member.create!(fname: 'Tim', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember3 = Member.create!(fname: 'Jade', lname: 'Henry', email: 'JohnHenry@email.com')

      visit new_lineage_path
      select 'John', :from => 'lineage_member_id', match: :first
      select 'Tim', :from => 'lineage_father', match: :first
      select 'Jade', :from => 'lineage_son', match: :first
      click_on 'Submit'
      visit lineages_path
      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
      expect(page).to(have_content('Jade'))
    end
  end

  describe 'edit', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember2 = Member.create!(fname: 'Tim', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember3 = Member.create!(fname: 'Jade', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember4 = Member.create!(fname: 'Slim', lname: 'Henry', email: 'JohnHenry@email.com')

      testLineage = Lineage.create!(member_id: testMember1.id, father: testMember2.id, son: testMember3.id)
      visit lineages_path
      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
      expect(page).to(have_content('Jade'))

      visit edit_lineage_path(id: testLineage.id)
      select 'Slim', :from => 'lineage_member_id', match: :first
      select 'John', :from => 'lineage_father', match: :first
      click_on 'Submit'
      visit lineages_path
      expect(page).to(have_content('Slim'))
      expect(page).not_to(have_content('Tim'))
    end
  end

  describe 'Testing Delete', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember2 = Member.create!(fname: 'Tim', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember3 = Member.create!(fname: 'Jade', lname: 'Henry', email: 'JohnHenry@email.com')

      visit new_lineage_path
      select 'John', :from => 'lineage_member_id', match: :first
      select 'Tim', :from => 'lineage_father', match: :first
      select 'Jade', :from => 'lineage_son', match: :first
      click_on 'Submit'
      visit lineages_path

      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
      expect(page).to(have_content('Jade'))

      click_on 'Destroy', match: :first

      begin
        page.driver.browser.switch_to.alert.accept
      rescue StandardError
        Selenium::WebDriver::Error::NoSuchAlertError
      end

      expect(page).not_to(have_content('John'))
    end
  end
end
