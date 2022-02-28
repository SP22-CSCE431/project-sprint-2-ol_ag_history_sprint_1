# frozen_string_literal: true

# location: spec/unit/unit_spec.rb
require 'rails_helper'

# def setup
#   test_user = {email: 'user@test.com', password: 'testuser'}
#   sign_up(test_user)
#   @auth_tokens = auth_tokens_for_user(test_user)
# end
OmniAuth.config.test_mode = true

RSpec.describe(Member, type: :model) do
  subject do
    described_class.new(fname: 'Jerome', lname: 'Wood', email: 'Jeromewood@gmail.com', joinDate: Date.new(2001, 1, 1), gradDate: Date.new(2001, 1, 1),
                        phoneNumber: '(282)-1231-432', city: 'Dallas', admin: 0, major: 'CS'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'is not valid without a names and email' do
    subject.fname = nil
    subject.lname = nil
    subject.email = nil
    expect(subject).not_to(be_valid)
  end

  it 'is valid without unnecessary attributes' do
    subject.joinDate = nil
    subject.gradDate = nil
    subject.phoneNumber = nil
    subject.city = nil
    subject.admin = nil
    subject.major = nil
    subject.active = nil
    expect(subject).to(be_valid)
  end
end

