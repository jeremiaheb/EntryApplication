require "application_system_test_case"

class FishSamplesTest < ApplicationSystemTestCase
  test "new fish sample" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    diver = FactoryGirl.create(:diver, boatlog_manager: boatlog_manager)

    visit root_url
    find(".samples-link").click

    find("input#diver_username").fill_in(with: diver.username)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    p page.find("div.alert").text

    take_screenshot
  end
end
