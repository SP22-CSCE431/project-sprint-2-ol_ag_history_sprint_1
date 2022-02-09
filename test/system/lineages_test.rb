require "application_system_test_case"

class LineagesTest < ApplicationSystemTestCase
  setup do
    @lineage = lineages(:one)
  end

  test "visiting the index" do
    visit lineages_url
    assert_selector "h1", text: "Lineages"
  end

  test "creating a Lineage" do
    visit lineages_url
    click_on "New Lineage"

    fill_in "Big", with: @lineage.big
    fill_in "Little", with: @lineage.little
    fill_in "Memberid", with: @lineage.memberID
    click_on "Create Lineage"

    assert_text "Lineage was successfully created"
    click_on "Back"
  end

  test "updating a Lineage" do
    visit lineages_url
    click_on "Edit", match: :first

    fill_in "Big", with: @lineage.big
    fill_in "Little", with: @lineage.little
    fill_in "Memberid", with: @lineage.memberID
    click_on "Update Lineage"

    assert_text "Lineage was successfully updated"
    click_on "Back"
  end

  test "destroying a Lineage" do
    visit lineages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lineage was successfully destroyed"
  end
end
