require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should display the registration page" do
    get new_registration_url

    assert_response :success
  end

  test "should create a valid user" do
    assert_difference("User.count", 1) do
      post registration_url, params: {
        user: {
          first_name: "Churchill",
          last_name: "Aka",
          email_address: "new.user@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to root_url

    follow_redirect!

    assert_response :success
    assert_select "span", text: "You are signed in"
  end

  test "should not create an invalid user" do
    assert_no_difference("User.count") do
      post registration_url, params: {
        user: {
          first_name: "",
          last_name: "",
          email_address: "invalid@example.com",
          password: "password123",
          password_confirmation: "different-password"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end