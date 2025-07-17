require "application_system_test_case"

class CoralsTest < ApplicationSystemTestCase
  test "new coral" do
    admin_diver = FactoryBot.create(:diver, role: "admin")

    visit root_url
    find(".login-link").click
    login_as_diver(admin_diver)
    find(".corals-link").click
    find(".new-coral-button").click

    find("input#coral_code").fill_in(with: "ACR CERV")
    find("input#coral_scientific_name").fill_in(with: "Acropora cervicornis")
    find("input#coral_common_name").fill_in(with: "Staghorn Coral")
    find("input#coral_short_code").fill_in(with: "ACER")
    find("input#coral_rank").fill_in(with: "30")

    find("body").click
    find("input[type=submit]").click

    assert_selector ".usa-alert", text: "Coral was successfully created"

    assert_equal 1, Coral.count

    coral = Coral.first
    assert_equal "ACR CERV", coral.code
    assert_equal "Acropora cervicornis", coral.scientific_name
    assert_equal "Staghorn Coral", coral.common_name
    assert_equal "ACER", coral.short_code
    assert_equal 30, coral.rank
  end
end
