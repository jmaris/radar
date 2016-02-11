  require 'test_helper'

class CpuAlertsControllerTest < ActionController::TestCase
  setup do
    @cpu_alert = cpu_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cpu_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cpu_alert" do
    assert_difference('CpuAlert.count') do
      post :create, cpu_alert: { addressee: @cpu_alert.addressee, check_interval: @cpu_alert.check_interval, cpu_threshold: @cpu_alert.cpu_threshold, machine_id: @cpu_alert.machine_id, triggered: @cpu_alert.triggered }
    end

    assert_redirected_to cpu_alert_path(assigns(:cpu_alert))
  end

  test "should show cpu_alert" do
    get :show, id: @cpu_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cpu_alert
    assert_response :success
  end

  test "should update cpu_alert" do
    patch :update, id: @cpu_alert, cpu_alert: { addressee: @cpu_alert.addressee, check_interval: @cpu_alert.check_interval, cpu_threshold: @cpu_alert.cpu_threshold, machine_id: @cpu_alert.machine_id, triggered: @cpu_alert.triggered }
    assert_redirected_to cpu_alert_path(assigns(:cpu_alert))
  end

  test "should destroy cpu_alert" do
    assert_difference('CpuAlert.count', -1) do
      delete :destroy, id: @cpu_alert
    end

    assert_redirected_to cpu_alerts_path
  end
end
