require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "authenticated users can GET index" do
    sign_in users(:tom)
    get conversations_index_url
    assert_response :success
  end

end
