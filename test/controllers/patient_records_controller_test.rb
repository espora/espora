require 'test_helper'

class PatientRecordsControllerTest < ActionController::TestCase
  test "should get havad" do
    get :havad
    assert_response :success
  end

end
