require 'test_helper'

class RamAlertsControllerTest < ActionController::TestCase
  setup do
    @ram_alert = ram_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ram_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ram_alert" do
    assert_difference('RamAlert.count') do
      post :create, ram_alert: { threshold: @ram_alert.threshold }
    end

    assert_redirected_to ram_alert_path(assigns(:ram_alert))
  end

  test "should show ram_alert" do
    get :show, id: @ram_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ram_alert
    assert_response :success
  end

  test "should update ram_alert" do
    patch :update, id: @ram_alert, ram_alert: { threshold: @ram_alert.threshold }
    assert_redirected_to ram_alert_path(assigns(:ram_alert))
  end

  test "should destroy ram_alert" do
    assert_difference('RamAlert.count', -1) do
      delete :destroy, id: @ram_alert
    end

    assert_redirected_to ram_alerts_path
  end
end
