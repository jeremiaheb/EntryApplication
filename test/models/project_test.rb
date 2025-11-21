require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    project = FactoryBot.create(:project)
    assert project.valid?
  end
end
