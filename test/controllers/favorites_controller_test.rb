require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get new_user_session_path
    assert_response :success
  end

end
