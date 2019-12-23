require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "authenticated users can GET index" do
    assert true
  end

end
