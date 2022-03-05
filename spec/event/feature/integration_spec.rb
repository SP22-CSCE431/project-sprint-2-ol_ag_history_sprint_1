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

  describe 'Creating Full Event', type: :feature do
    it 'valid inputs' do
      visit new_event_path
      fill_in 'Name',  with: 'John' 
      fill_in 'Description',  with: 'JH@gmail.com'
      fill_in 'Location',	with: 'Henry'
      fill_in 'Start time',  with: '05/04/2023 11:39AM'
      fill_in 'End time',  with: '05/04/2023 11:39AM'
      click_on 'Create Event'
      visit events_path
    end
  end
end
