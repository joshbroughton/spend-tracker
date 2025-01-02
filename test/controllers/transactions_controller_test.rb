require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get transactions_upload_url
    assert_response :success
  end
end
