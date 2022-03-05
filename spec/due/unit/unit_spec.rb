# frozen_string_literal: true

# location: spec/unit/unit_spec.rb
require 'rails_helper'

# def setup
#   test_user = {email: 'user@test.com', password: 'testuser'}
#   sign_up(test_user)
#   @auth_tokens = auth_tokens_for_user(test_user)
# end
OmniAuth.config.test_mode = true

RSpec.describe(Due, type: :model) do
  testMember1 = Member.create!(fname: "John", lname: "Henry", email: "JohnHenry@email.com")
  testEvent1 = Event.create!(name: "Funeral", location: "Church", start_time: "03/03/2022 10:00PM", end_time: "03/03/2022 11:00PM", description: "N/A")

  subject do
    described_class.new(member_id: testMember1.id, event_id: testEvent1.id, dueAmount: "0", paid: "false")
  end

  it 'All initializations done correctly' do
    expect(subject).to(be_valid)
  end

  it 'Paid' do
    subject.paid = "true"
    expect(subject).to(be_valid)
  end

  it 'Due amount with decimal' do
    subject.dueAmount = "120.99"
    expect(subject).to(be_valid)
  end
end
