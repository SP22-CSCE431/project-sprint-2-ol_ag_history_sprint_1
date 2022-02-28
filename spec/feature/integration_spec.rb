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
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_user]
    # visit new_admin_session_path click_on "Sign in with Google"
    visit admin_google_oauth2_omniauth_authorize_path
    # Permission.create!(description: 'admin') if Permission.where(description: 'admin').first.nil?
    # unless Admin.where(email: 'userdoe@example.com').first.nil? == false
    #   Admin.create!(email: 'userdoe@example.com', full_name: 'User Doe', uid: '123456789', avatar_url: 'https://lh3.googleusercontent.com/url/photo.jpg')
    # end
  end

  # Members Test
  describe 'Creating Min Requirements for Member', type: :feature do
    it 'valid inputs' do
      visit new_member_path
      fill_in 'Fname', with: 'John' 
      fill_in 'Lname', with: 'Henry'
      fill_in 'Email', with: 'JH@gmail.com'
      click_on 'Create Member'
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JH@gmail.com')
    end
  end

  describe 'Creating Full Member', type: :feature do
    it 'valid inputs' do
      visit new_member_path
      fill_in 'Fname',  with: 'John' 
      fill_in 'Lname',	with: 'Henry'
      fill_in 'Email',  with: 'JH@gmail.com'
      fill_in 'Joindate',  with: '01/01/2001'
      fill_in 'Graddate',  with: '01/01/2010'
      fill_in 'City',  with: 'Austin'
      check "Admin"
      fill_in 'Major',  with: 'CS Major'
      click_on 'Create Member'
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
      fill_in 'Lname', with: 'Smith'
      fill_in 'City', with: 'Dallas'
      click_on 'Update Member'
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
      test_member = Member.create!(fname: 'John', lname: 'Henry', joinDate: '01/01/2001', gradDate: "01/01/2010", email: "JH@gmail.com", city: "Austin", admin: 0, major: "CS Major", active: 1)
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

      test_member.destroy
    end
  end

  # Events Test
  # Most of these atrributes are required

  describe 'Event test 1', type: :feature do
    it 'valid inputs' do
      testEvent = Event.create!(eventID: 1, name: 'Birthday', location: 'My House', time: '20:00PM')
      visit events_path
      expect(page).to(have_content(1))
      expect(page).to(have_content('Birthday'))
      expect(page).to(have_content('My House'))
      expect(page).to(have_content('20:00PM'))
    end
  end

  describe 'Event test 2', type: :feature do
    it 'valid inputs' do
      testEvent = Event.create!(eventID: 2, name: 'Funeral', location: 'Church', time: '12:00AM')
      visit events_path
      expect(page).to(have_content(2))
      expect(page).to(have_content('Funeral'))
      expect(page).to(have_content('Church'))
      expect(page).to(have_content('12:00AM'))
    end
  end

  # Lineage

  describe 'Lineage three diffrent member nodes', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember2 = Member.create!(fname: 'Tim', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember3 = Member.create!(fname: 'Jade', lname: 'Henry', email: 'JohnHenry@email.com')

      testNode = Lineage.create!(member_id: testMember1.id, father: testMember2.id, son: testMember3.id)
      visit lineages_path
      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
      expect(page).to(have_content('Jade'))
    end
  end

  describe 'Lineage one null node', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
      testMember2 = Member.create!(fname: 'Tim', lname: 'Henry', email: 'JohnHenry@email.com')

      testNode = Lineage.create!(member_id: testMember1.id, father: testMember2.id, son: nil)
      visit lineages_path
      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
    end
  end
end
