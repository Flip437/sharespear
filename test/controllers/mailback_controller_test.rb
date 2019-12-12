require 'test_helper'

class MailbackControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mailback_new_url
    assert_response :success
  end

end
