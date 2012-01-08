require 'test_helper'

class PatchesControllerTest < ActionController::TestCase
  test "should get nearest" do
    get :nearest
    assert_response :success
  end

end
