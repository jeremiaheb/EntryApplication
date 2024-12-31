require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  setup do
    # Render error pages instead of raising on routing errors, like would happen
    # in production
    Rails.configuration.action_dispatch.show_exceptions = true
  end
end
