require 'test_helper'

class StorageAlertsControllerTest < ActionController::TestCase
  setup do
    @storage_alert = storage_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:storage_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create storage_alert" do
    assert_difference('StorageAlert.count') do
      post :create, storage_alert: { addressee: @storage_alert.addressee, check_interval: @storage_alert.check_interval, machine_id: @storage_alert.machine_id, storage_threshold: @storage_alert.storage_threshold, triggered: @storage_alert.triggered }
    end

    assert_redirected_to storage_alert_path(assigns(:storage_alert))
  end

  test "should show storage_alert" do
    get :show, id: @storage_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @storage_alert
    assert_response :success
  end

  test "should update storage_alert" do
    patch :update, id: @storage_alert, storage_alert: { addressee: @storage_alert.addressee, check_interval: @storage_alert.check_interval, machine_id: @storage_alert.machine_id, storage_threshold: @storage_alert.storage_threshold, triggered: @storage_alert.triggered }
    assert_redirected_to storage_alert_path(assigns(:storage_alert))
  end

  test "should destroy storage_alert" do
    assert_difference('StorageAlert.count', -1) do
      delete :destroy, id: @storage_alert
    end

    assert_redirected_to storage_alerts_path
  end
end
