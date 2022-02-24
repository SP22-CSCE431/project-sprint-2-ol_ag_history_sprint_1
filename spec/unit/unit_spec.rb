# location: spec/unit/unit_spec.rb
require 'rails_helper'

# def setup
#   test_user = {email: 'user@test.com', password: 'testuser'}
#   sign_up(test_user)
#   @auth_tokens = auth_tokens_for_user(test_user) 
# end
OmniAuth.config.test_mode = true

RSpec.describe Member, type: :model do
  subject do
    described_class.new(fname: "Jerome", lname: "Wood", email: "Jeromewood@gmail.com", joinDate: Date.new(2001,1,1), gradDate: Date.new(2001,1,1),
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
    subject.gradDate = nil
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
      subject.eventID = nil
      expect(subject).to be_valid
  end
end

RSpec.describe Lineage, type: :model do
    testMember1 = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com")
    testMember2 = Member.create(:fname => "Red", :lname => "Henry", :email => "JohnHenry@email.com")
    testMember3 = Member.create(:fname => "Ned", :lname => "Henry", :email => "JohnHenry@email.com")

    subject do
      described_class.new(member_id: testMember1.id, big: nil, little: nil)
    end

    it 'Big and Little nil' do
      expect(subject).not_to be_valid
    end

    it 'Little nil' do
      subject.big = testMember2.id
      expect(subject).to be_valid
    end

    it 'Big nil' do
      subject.little = testMember2.id
      expect(subject).to be_valid
    end

    it 'No duplicates in instance' do 
      subject.big= testMember1.id
      expect(subject).not_to be_valid
    end

    it 'Same Member id' do
      testlineage = Lineage.create(member_id: testMember2.id, big: testMember1.id, little: testMember3.id)
      subject.member_id = testMember2.id
      expect(subject).not_to be_valid
    end

    it 'Same Big' do
      testlineage = Lineage.create(member_id: testMember2.id, big: testMember3.id, little: testMember1  .id)
      subject.big = testMember3.id
      expect(subject).not_to be_valid
    end

    it 'Same Little' do
      testlineage = Lineage.create(member_id: testMember2.id, big: testMember1.id, little: testMember3.id)
      subject.little = testMember3.id
      expect(subject).not_to be_valid
    end

    it 'Common inputs' do
        subject.big = testMember2.id
        subject.little = testMember3.id
        expect(subject).to be_valid
    end
end




