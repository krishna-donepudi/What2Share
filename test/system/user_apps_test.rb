require "application_system_test_case"

class UserAppsTest < ApplicationSystemTestCase
  setup do
    @user_app = user_apps(:one)
  end

  test "visiting the index" do
    visit user_apps_url
    assert_selector "h1", text: "User Apps"
  end

  test "creating a User app" do
    visit user_apps_url
    click_on "New User App"

    fill_in "App", with: @user_app.app_id
    fill_in "User", with: @user_app.user_id
    click_on "Create User app"

    assert_text "User app was successfully created"
    click_on "Back"
  end

  test "updating a User app" do
    visit user_apps_url
    click_on "Edit", match: :first

    fill_in "App", with: @user_app.app_id
    fill_in "User", with: @user_app.user_id
    click_on "Update User app"

    assert_text "User app was successfully updated"
    click_on "Back"
  end

  test "destroying a User app" do
    visit user_apps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User app was successfully destroyed"
  end
end
