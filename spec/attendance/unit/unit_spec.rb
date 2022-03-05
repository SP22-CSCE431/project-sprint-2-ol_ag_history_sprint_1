# frozen_string_literal: true

# location: spec/unit/unit_spec.rb
require 'rails_helper'

# def setup
#   test_user = {email: 'user@test.com', password: 'testuser'}
#   sign_up(test_user)
#   @auth_tokens = auth_tokens_for_user(test_user)
# end
OmniAuth.config.test_mode = true

RSpec.describe(Attendance, type: :model) do
  testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com")
  testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")

  subject do
    described_class.new(member_id: testMember1.id, event_id: testEvent1.id, rsvp: "false", attended: "false")
  end

  it 'No RSVP and no Attended' do
    expect(subject).to(be_valid)
  end

  it 'RSVP' do
    subject.rsvp = "true"
    expect(subject).to(be_valid)
  end

  it 'Attended' do
    subject.attended = "true"
    expect(subject).to(be_valid)
  end
end
