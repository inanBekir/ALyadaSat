require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get new_user_session_path
    assert_response :success
  end

end
