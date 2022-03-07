require 'rails_helper'
require 'date'

OmniAuth.config.silence_get_warning = true
RSpec.describe('Authentication', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_user]
    # visit new_admin_session_path click_on 'Sign in with Google'
    visit admin_google_oauth2_omniauth_authorize_path
    # Permission.create!(description: 'admin') if Permission.where(description: 'admin').first.nil?
    # unless Admin.where(email: 'userdoe@example.com').first.nil? == false
    #   Admin.create!(email: 'userdoe@example.com', full_name: 'User Doe', uid: '123456789', avatar_url: 'https://lh3.googleusercontent.com/url/photo.jpg')
    # end
  end

  #2022-03-06 13:00:00 UTC
  describe 'Event test 1', type: :feature do
    it 'valid inputs' do
      visit new_event_path
      fill_in 'Name', with: 'Birthday'
      fill_in 'Description', with: 'Celebration of the Presidents birthday'
      fill_in 'Location', with: 'My House'
      fill_in 'Start Time', with: DateTime.new(2023,3,3,17,0,0)
      fill_in 'End Time', with: DateTime.new(2023,3,3,21,0,0)
      click_on 'Submit'
      expect(page).to(have_content('Birthday'))
      expect(page).to(have_content('Celebration of the Presidents birthday'))
      expect(page).to(have_content('My House'))
      expect(page).to(have_content('03/03/2023 05:00PM'))
      expect(page).to(have_content('03/03/2023 09:00PM'))
    end
  end

  describe 'Delete Event', type: :feature do
    it 'valid inputs' do
        testEvent = Event.create!(name: 'Birthday', description: 'Celebration of the Presidents birthday', location: 'My House', start_time: '03/03/2023 9:00PM', end_time: '03/03/2023 11:00PM')
        visit new_event_path
        fill_in 'Name', with: 'Birthday'
        fill_in 'Description', with: 'Celebration of the Presidents birthday'
        fill_in 'Location', with: 'My House'
        fill_in 'Start Time', with: DateTime.new(2023,3,3,21,0,0)
        fill_in 'End Time', with: DateTime.new(2023,3,3,23,0,0)
        click_on 'Submit'
        expect(page).to(have_content('Birthday'))
        expect(page).to(have_content('Celebration of the Presidents birthday'))
        expect(page).to(have_content('My House'))
        expect(page).to(have_content('03/03/2023 09:00PM'))
        expect(page).to(have_content('03/03/2023 11:00PM'))
        visit edit_event_path(id: testEvent.id)
        click_on 'Remove Event'
        testEvent.destroy
    end
  end

  describe 'Edit Event', type: :feature do
    it 'valid inputs' do
        testEvent = Event.create(:name => 'Celebration', :description => 'Celebrating the welcoming of the new President', :location => 'My House', :start_time => '03/06/2022 4:00PM', :end_time => '03/06/2022 7:00PM')
        visit edit_event_path(id: testEvent.id)
        fill_in 'Name', with: 'Celebration'
        fill_in 'Description', with: 'Celebrating the welcoming of the new President'
        fill_in 'Location', with: 'My House'
        fill_in 'Start Time', with: DateTime.new(2023,3,12,16,0,0)
        fill_in 'End Time', with: DateTime.new(2023,3,12,19,0,0)
        click_on 'Submit'
        expect(page).to(have_content('Celebration'))
        expect(page).to(have_content('Celebrating the welcoming of the new President'))
        expect(page).to(have_content('My House'))
        expect(page).to(have_content('03/12/2023 04:00PM'))
        expect(page).to(have_content('03/12/2023 07:00PM'))
    end
  end



end