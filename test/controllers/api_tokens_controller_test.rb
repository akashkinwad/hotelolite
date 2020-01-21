require 'test_helper'

class ApiTokensControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_tokens_index_url
    assert_response :success
  end

  test "should get edit" do
    get api_tokens_edit_url
    assert_response :success
  end

  test "should get new" do
    get api_tokens_new_url
    assert_response :success
  end

end
