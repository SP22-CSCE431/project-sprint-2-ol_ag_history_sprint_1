require "test_helper"

class LineagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lineage = lineages(:one)
  end

  test "should get index" do
    get lineages_url
    assert_response :success
  end

  test "should get new" do
    get new_lineage_url
    assert_response :success
  end

  test "should create lineage" do
    assert_difference('Lineage.count') do
      post lineages_url, params: { lineage: { big: @lineage.big, little: @lineage.little, memberID: @lineage.memberID } }
    end

    assert_redirected_to lineage_url(Lineage.last)
  end

  test "should show lineage" do
    get lineage_url(@lineage)
    assert_response :success
  end

  test "should get edit" do
    get edit_lineage_url(@lineage)
    assert_response :success
  end

  test "should update lineage" do
    patch lineage_url(@lineage), params: { lineage: { big: @lineage.big, little: @lineage.little, memberID: @lineage.memberID } }
    assert_redirected_to lineage_url(@lineage)
  end

  test "should destroy lineage" do
    assert_difference('Lineage.count', -1) do
      delete lineage_url(@lineage)
    end

    assert_redirected_to lineages_url
  end
end
