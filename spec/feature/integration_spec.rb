# location: spec/feature/integration_spec.rb
require 'rails_helper'

#Members Test

RSpec.describe 'Creating Min Requirements for Member', type: :feature do
  scenario 'valid inputs' do
    testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com")
    visit members_path
    expect(page).to have_content('John')
    expect(page).to have_content('Henry')
    expect(page).to have_content('JohnHenry@email.com')
  end
end

RSpec.describe 'Add join date', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com", :joinDate => Date.new(2001,3,6))
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@email.com')
      expect(page).to have_content('2001-03-06')
    end
  end

  RSpec.describe 'Add grad date', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com", :joinDate => Date.new(2001,3,6), 
      :gradeDate => Date.new(2005,8,2))
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@email.com')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
    end
  end

  RSpec.describe 'Add phone number', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com", :joinDate => Date.new(2001,3,6), 
      :gradeDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234")
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@email.com')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
    end
  end

  RSpec.describe 'Add city', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com", :joinDate => Date.new(2001,3,6), 
      :gradeDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234" , :city => "Dallas")
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@email.com')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
    end
  end

  RSpec.describe 'Add admin', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com", :joinDate => Date.new(2001,3,6), 
      :gradeDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234" , :city => "Dallas", :admin => 0)
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@email.com')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('false')
    end
  end

  RSpec.describe 'Full member', type: :feature do
    it 'valid inputs' do
      testMember = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com", :joinDate => Date.new(2001,3,6), 
      :gradeDate => Date.new(2005,8,2), :phoneNumber => "(345)-6849-234", :city => "Dallas", :admin => 0, :major => "Material Science") 
      visit members_path
      expect(page).to have_content('John')
      expect(page).to have_content('Henry')
      expect(page).to have_content('JohnHenry@email.com')
      expect(page).to have_content('2001-03-06')
      expect(page).to have_content('2005-08-02')
      expect(page).to have_content('(345)-6849-234')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('false')
      expect(page).to have_content('Material Science')
    end
  end

  #Events Test
  #Most of these atrributes are required

  RSpec.describe 'Event test 1', type: :feature do
    it 'valid inputs' do
      testEvent = Event.create(:eventID => 1, :name => "Birthday", :location => "My House", :time => "20:00PM")
      visit events_path
      expect(page).to have_content(1)
      expect(page).to have_content('Birthday')
      expect(page).to have_content('My House')
      expect(page).to have_content('20:00PM')
    end
  end

  RSpec.describe 'Event test 2', type: :feature do
    it 'valid inputs' do
      testEvent = Event.create(:eventID => 2, :name => "Funeral", :location => "Church", :time => "12:00AM")
      visit events_path
      expect(page).to have_content(2)
      expect(page).to have_content('Funeral')
      expect(page).to have_content('Church')
      expect(page).to have_content('12:00AM')
    end
  end

  #Lineage 

  RSpec.describe 'Lineage three diffrent member nodes', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com")
      testMember2 = Member.create(:fname => "Tim", :lname => "Henry", :email => "JohnHenry@email.com")
      testMember3 = Member.create(:fname => "Jade", :lname => "Henry", :email => "JohnHenry@email.com")

      testNode = Lineage.create(:member_id => testMember1.id, :big => testMember2.id, :little => testMember3.id)
      visit lineages_path
      expect(page).to have_content('John')
      expect(page).to have_content('Tim')
      expect(page).to have_content('Jade')
    end
  end

  RSpec.describe 'Lineage two identical nodes', type: :feature do
    it 'valid inputs' do
      testMember1 = Member.create(:fname => "John", :lname => "Henry", :email => "JohnHenry@email.com")
      testMember2 = Member.create(:fname => "Tim", :lname => "Henry", :email => "JohnHenry@email.com")

      testNode = Lineage.create(:member_id => testMember1.id, :big => testMember2.id, :little => testMember2.id)
      visit lineages_path
      expect(page).to have_content('John')
      expect(page).to have_content('Tim')
    end
  end




