require "application_system_test_case"

class PoolsTest < ApplicationSystemTestCase
  setup do
    @pool = pools(:one)
  end

  test "visiting the index" do
    visit pools_url
    assert_selector "h1", text: "Pools"
  end

  test "should create pool" do
    visit pools_url
    click_on "New pool"

    fill_in "End at", with: @pool.end_at
    fill_in "Pool type", with: @pool.pool_type
    fill_in "Start at", with: @pool.start_at
    fill_in "User", with: @pool.user_id
    fill_in "User max", with: @pool.user_max
    fill_in "User min", with: @pool.user_min
    click_on "Create Pool"

    assert_text "Pool was successfully created"
    click_on "Back"
  end

  test "should update Pool" do
    visit pool_url(@pool)
    click_on "Edit this pool", match: :first

    fill_in "End at", with: @pool.end_at.to_s
    fill_in "Pool type", with: @pool.pool_type
    fill_in "Start at", with: @pool.start_at.to_s
    fill_in "User", with: @pool.user_id
    fill_in "User max", with: @pool.user_max
    fill_in "User min", with: @pool.user_min
    click_on "Update Pool"

    assert_text "Pool was successfully updated"
    click_on "Back"
  end

  test "should destroy Pool" do
    visit pool_url(@pool)
    click_on "Destroy this pool", match: :first

    assert_text "Pool was successfully destroyed"
  end
end
