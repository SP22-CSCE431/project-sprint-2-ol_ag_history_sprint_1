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
    scenario 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu")
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')

      testMember.destroy()
      expect(defined?(testMember))
    end
  end

  describe 'Add join date', type: :feature do
      it 'valid inputs' do
        testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6))
        visit members_path
        expect(page).to have_content('John')
        expect(page).to have_content('Henry')
        expect(page).to have_content('JohnHenry@tamu.edu')
        expect(page).to have_content('2001-03-06')
      end
    end

  describe 'Creating Edit Full Member', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6), 
      :gradDate => Date.new(2005,8,2))
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
    end
  end

  describe 'Delete Member', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6), 
      :gradDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234")
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
    end
  end

  describe 'Add city', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6), 
      :gradDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234" , :city => "Dallas")
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
    end
  end

  describe 'Add admin', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6), 
      :gradDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234" , :city => "Dallas", :admin => 0)
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('false')
      expect(page).to have_content('CS Major')
      expect(page).to have_content('true')
    end
  end

  describe 'Creating Edit Full Member', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6), 
      :gradDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234", :city => "Dallas", :admin => 1, :major => "Material Science") 
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('CS Major')
      expect(page).to have_content('true')
      expect(page).to have_content('false')
    end
  end

  describe 'Delete Member', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu", :joinDate => Date.new(2001,3,6), 
      :gradDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234", :city => "Dallas", :admin => 1, :major => "Material Science", :active => 1) 
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@tamu.edu')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('true')
      expect(page).to have_content('Material Science')
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
      testMember1 = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu")
      testMember2 = Member.create(:fname => "Tim", :lname => "Henry", :email => "JohnHenry@tamu.edu")
      testMember3 = Member.create(:fname => "Jade", :lname => "Henry", :email => "JohnHenry@tamu.edu")

      testNode = Lineage.create!(member_id: testMember1.id, father: testMember2.id, son: testMember3.id)
      visit lineages_path
      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
      expect(page).to(have_content('Jade'))
    end
  end

  describe 'Lineage one null node', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@tamu.edu")
      testMember2 = Member.create(:fname => "Tim", :lname => "Henry", :email => "JohnHenry@tamu.edu")

      testNode = Lineage.create!(member_id: testMember1.id, father: testMember2.id, son: nil)
      visit lineages_path
      expect(page).to(have_content('John'))
      expect(page).to(have_content('Tim'))
    end
  end

  #Attendance Test
  describe 'rsvped and attended', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com")
      testEvent1 = Event.create!(name: "Funeral", location: "Church", time: "12:00AM")
      visit new_attendance_path
      select "John", :from => "Member"
      select "Funeral", :from => "Event"
      check 'Rsvp'
      check 'Attended'
      click_on "Create Attendance"
      visit attendances_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('true')
      expect(page).to have_content('true')
    end
  end

  describe 'no rsvp and attended', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com")
      testEvent1 = Event.create!(name: "Funeral", location: "Church", time: "12:00AM")
      visit new_attendance_path
      select "John", :from => "Member"
      select "Funeral", :from => "Event"
      check 'Attended'
      click_on "Create Attendance"
      visit attendances_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('false')
      expect(page).to have_content('true')
    end
  end

  #Dues Test
  describe 'due amount filled and paid', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com")
      testEvent1 = Event.create!(name: "Funeral", location: "Church", time: "12:00AM")
      visit new_due_path
      select "John", :from => "Member"
      select "Funeral", :from => "Event"
      fill_in "Dueamount", with: 120
      check 'Paid'
      click_on "Create Due"
      visit dues_path
      expect(page).to have_content('John')
      expect(page).to have_content('Funeral')
      expect(page).to have_content('120')
      expect(page).to have_content('true')
    end
  end
end


