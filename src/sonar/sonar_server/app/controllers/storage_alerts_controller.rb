class StorageAlertsController < ApplicationController
  before_action :set_storage_alert, only: [:show, :edit, :update, :destroy]
  before_action :get_machine_ids, only: [:edit, :new, :show, :create, :update]
  # GET /storage_alerts
  # GET /storage_alerts.json
  def index
    @storage_alerts = StorageAlert.all
  end

  # GET /storage_alerts/1
  # GET /storage_alerts/1.json
  def show
  end

  # GET /storage_alerts/new
  def new
    @storage_alert = StorageAlert.new
  end

  # GET /storage_alerts/1/edit
  def edit
  end

  # POST /storage_alerts
  # POST /storage_alerts.json
  def create
    @storage_alert = StorageAlert.new(storage_alert_params)

    respond_to do |format|
      if @storage_alert.save
        format.html { redirect_to @storage_alert, notice: 'Storage alert was successfully created.' }
        format.json { render :show, status: :created, location: @storage_alert }
      else
        format.html { render :new }
        format.json { render json: @storage_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storage_alerts/1
  # PATCH/PUT /storage_alerts/1.json
  def update
    respond_to do |format|
      if @storage_alert.update(storage_alert_params)
        format.html { redirect_to @storage_alert, notice: 'Storage alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @storage_alert }
      else
        format.html { render :edit }
        format.json { render json: @storage_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storage_alerts/1
  # DELETE /storage_alerts/1.json
  def destroy
    @storage_alert.destroy
    respond_to do |format|
      format.html { redirect_to storage_alerts_url, notice: 'Storage alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storage_alert
      @storage_alert = StorageAlert.find(params[:id])
    end

    def get_machine_ids
      @machine_ids = Machine.ids
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def storage_alert_params
      params.require(:storage_alert).permit(:machine_id, :addressee, :path, :threshold, :check_interval)
    end
end
