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
