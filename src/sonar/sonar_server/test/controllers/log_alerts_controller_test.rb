require 'test_helper'

class LogAlertsControllerTest < ActionController::TestCase
  setup do
    @log_alert = log_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_alert" do
    assert_difference('LogAlert.count') do
      post :create, log_alert: { arguments: @log_alert.arguments, logger_type: @log_alert.logger_type, path: @log_alert.path }
    end

    assert_redirected_to log_alert_path(assigns(:log_alert))
  end

  test "should show log_alert" do
    get :show, id: @log_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log_alert
    assert_response :success
  end

  test "should update log_alert" do
    patch :update, id: @log_alert, log_alert: { arguments: @log_alert.arguments, logger_type: @log_alert.logger_type, path: @log_alert.path }
    assert_redirected_to log_alert_path(assigns(:log_alert))
  end

  test "should destroy log_alert" do
    assert_difference('LogAlert.count', -1) do
      delete :destroy, id: @log_alert
    end

    assert_redirected_to log_alerts_path
  end
end
