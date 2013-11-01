require 'test_helper'

class RaceProgressesControllerTest < ActionController::TestCase

  test "should get show" do
    get :show ,:id => races(:one).to_param ,:date => "last"
    assert_response :success
  end
  
end
