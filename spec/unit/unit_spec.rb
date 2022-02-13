# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec.describe Member, type: :model do
  subject do
    described_class.new(fname: "Jerome", lname: "Wood", email: "Jeromewood@gmail.com", joinDate: Date.new(2001,1,1), gradeDate: Date.new(2001,1,1),
    phoneNumber: "(282)-1231-432", city: "Dallas", admin: 0, major: "CS")
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a names and email' do
    subject.fname = nil
    subject.lname = nil
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'is valid without unnecessary attributes' do
    subject.joinDate = nil
    subject.gradeDate = nil
    subject.phoneNumber = nil
    subject.city = nil
    subject.admin = nil
    subject.major = nil
    expect(subject).to be_valid
  end
end

RSpec.describe Event, type: :model do
    subject do
      described_class.new(eventID: 1, name: "Birthday", location: "My House", time: "4:00AM")
    end
  
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without a names and email' do
      subject.name = nil
      subject.location = nil
      subject.time = nil
      expect(subject).not_to be_valid
    end
  
    it 'is valid without unnecessary attributes' do
      subject.eventID
      expect(subject).to be_valid
  end
end




