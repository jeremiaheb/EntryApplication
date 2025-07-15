require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    # Render error pages instead of raising on routing errors, like would happen
    # in production
    Rails.configuration.action_dispatch.show_exceptions = true
  end

  private

  def login_as_diver(diver)
    find("input#diver_username").fill_in(with: diver.username)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click
  end

  def select2_choose(select_element, option:)
    # Close any open select2 that happens to be open for other reasons
    find("body").click

    select_element.sibling(".select2-container").find("a").click

    within(".select2-drop") do
      find(".select2-result", text: option).click
    end
  end
end
