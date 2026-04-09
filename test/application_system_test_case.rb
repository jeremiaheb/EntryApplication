require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  private

  def login_as_diver(diver)
    find("input#diver_login").fill_in(with: diver.email)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    assert_css("div", text: "Signed in successfully")
  end

  def select2_choose(select_element, option:)
  # Force Select2 initialization if not already done
  page.execute_script("$('.select2-container').select2('close')")

  # Click the select element to trigger Select2 opening
  select_element.click

  # Wait for the dropdown to appear
  dropdown = find(".select2-dropdown, .select2-drop", visible: true, wait: 5)

  # Find and click the option
  dropdown.find(".select2-results__option, .select2-result", text: option).click
  end
end
