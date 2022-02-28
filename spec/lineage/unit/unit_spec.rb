# frozen_string_literal: true

# location: spec/unit/unit_spec.rb
require 'rails_helper'

# def setup
#   test_user = {email: 'user@test.com', password: 'testuser'}
#   sign_up(test_user)
#   @auth_tokens = auth_tokens_for_user(test_user)
# end
OmniAuth.config.test_mode = true

RSpec.describe(Lineage, type: :model) do
  testMember1 = Member.create!(fname: 'John', lname: 'Henry', email: 'JohnHenry@email.com')
  testMember2 = Member.create!(fname: 'Red', lname: 'Henry', email: 'JohnHenry@email.com')
  testMember3 = Member.create!(fname: 'Ned', lname: 'Henry', email: 'JohnHenry@email.com')

  subject do
    described_class.new(member_id: testMember1.id, father: nil, son: nil)
  end

  it 'Big and Little nil' do
    expect(subject).not_to(be_valid)
  end

  it 'Little nil' do
    subject.father = testMember2.id
    expect(subject).to(be_valid)
  end

  it 'Big nil' do
    subject.son = testMember2.id
    expect(subject).to(be_valid)
  end

  it 'No duplicates in instance' do
    subject.father = testMember1.id
    expect(subject).not_to(be_valid)
  end

  it 'Same Member id' do
    testlineage = described_class.create!(member_id: testMember2.id, father: testMember1.id, son: testMember3.id)
    subject.member_id = testMember2.id
    expect(subject).not_to(be_valid)
  end

  it 'Same Big' do
    testlineage = described_class.create!(member_id: testMember2.id, father: testMember3.id, son: testMember1.id)
    subject.father = testMember3.id
    expect(subject).not_to(be_valid)
  end

  it 'Same Little' do
    testlineage = described_class.create!(member_id: testMember2.id, father: testMember1.id, son: testMember3.id)
    subject.son = testMember3.id
    expect(subject).not_to(be_valid)
  end

  it 'Common inputs' do
    subject.father = testMember2.id
    subject.son = testMember3.id
    expect(subject).to(be_valid)
  end
end
