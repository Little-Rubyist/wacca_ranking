require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get pilicies" do
    get home_pilicies_url
    assert_response :success
  end

  test "should get agreement" do
    get home_agreement_url
    assert_response :success
  end
end
