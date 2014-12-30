require 'test_helper'

class PatientRequestsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
