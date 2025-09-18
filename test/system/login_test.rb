require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test "login with invalid password" do
    diver = FactoryBot.create(:diver)

    visit root_url
    find(".login-link").click

    find("input#diver_login").fill_in(with: diver.email)
    find("input#diver_password").fill_in(with: diver.password + "BOGUS")
    find("input[type=submit]").click

    assert_css(".usa-alert", text: "Invalid Login or password")
  end

  test "login with email" do
    diver = FactoryBot.create(:diver, email: "diver@example.com")

    visit root_url
    find(".login-link").click

    find("input#diver_login").fill_in(with: diver.email)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    assert_css(".alert", text: "Signed in successfully")
  end

  test "login with email (case insensitive)" do
    diver = FactoryBot.create(:diver, email: "diver@example.com")

    visit root_url
    find(".login-link").click

    find("input#diver_login").fill_in(with: diver.email.upcase)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    assert_css(".alert", text: "Signed in successfully")
  end

  test "login with username" do
    diver = FactoryBot.create(:diver, username: "diver_example")

    visit root_url
    find(".login-link").click

    find("input#diver_login").fill_in(with: diver.username)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    assert_css(".alert", text: "Signed in successfully")
  end

  test "login with username (case insensitive)" do
    diver = FactoryBot.create(:diver, username: "diver_example")

    visit root_url
    find(".login-link").click

    find("input#diver_login").fill_in(with: diver.username.upcase)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    assert_css(".alert", text: "Signed in successfully")
  end
end
