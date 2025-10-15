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
    # Close any open select2 that happens to be open for other reasons
    page.execute_script("$('.select2-container').select2('close')")

    select_element.sibling(".select2-container").find(".select2-choice").click

    within(".select2-drop") do
      find(".select2-result", text: option).click
    end
  end
end
