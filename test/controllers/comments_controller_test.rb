require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get New" do
    get comments_New_url
    assert_response :success
  end

  test "should get Create" do
    get comments_Create_url
    assert_response :success
  end

end
