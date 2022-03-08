require 'rails_helper'

OmniAuth.config.test_mode = true

RSpec.describe(Event, type: :model) do
  testEvent = Event.create!(name: 'Birthday', description: 'Celebration of the Presidents birthday', location: 'My House', start_time: '03/03/2023 7:00PM', end_time: '03/03/2023 11:00PM')

  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'is not valid without a name, description, location, start and end times' do
    subject.name = nil
    subject.description = nil
    subject.location = nil
    subject.start_time = nil
    subject.end_time = nil
    expect(subject).not_to(be_valid)
  end
end
