require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get '/users/password/new'
    assert_response :success
  end

end
