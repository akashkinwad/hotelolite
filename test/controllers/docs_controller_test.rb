require 'test_helper'

class DocsControllerTest < ActionDispatch::IntegrationTest
  test "should get v1" do
    get docs_v1_url
    assert_response :success
  end

  test "should get v2" do
    get docs_v2_url
    assert_response :success
  end

end
