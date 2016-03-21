class LogAlertsController < ApplicationController
  before_action :set_log_alert, only: [:show, :edit, :update, :destroy]
  before_action :set_machines, only: [:edit, :new, :show, :create, :update]

  # GET /log_alerts
  # GET /log_alerts.json
  def index
    @log_alerts = LogAlert.all
  end

  # GET /log_alerts/1
  # GET /log_alerts/1.json
  def show
  end

  # GET /log_alerts/new
  def new
    @log_alert = LogAlert.new
  end

  # GET /log_alerts/1/edit
  def edit
  end

  # POST /log_alerts
  # POST /log_alerts.json
  def create
    @log_alert = LogAlert.new(log_alert_params)

    respond_to do |format|
      if @log_alert.save
        format.html { redirect_to @log_alert, notice: 'Log alert was successfully created.' }
        format.json { render :show, status: :created, location: @log_alert }
      else
        format.html { render :new }
        format.json { render json: @log_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_alerts/1
  # PATCH/PUT /log_alerts/1.json
  def update
    respond_to do |format|
      if @log_alert.update(log_alert_params)
        format.html { redirect_to @log_alert, notice: 'Log alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @log_alert }
      else
        format.html { render :edit }
        format.json { render json: @log_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_alerts/1
  # DELETE /log_alerts/1.json
  def destroy
    @log_alert.destroy
    respond_to do |format|
      format.html { redirect_to log_alerts_url, notice: 'Log alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_log_alert
    @log_alert = LogAlert.find(params[:id])
  end

  def set_machines
    machines = Machine.all
    @machines_hash = {}
    machines.each do |machine|
      @machines_hash[machine.alias] = machine.id
    end
  end

  # Never trust parameters from the internet, only allow the white list through.
  def log_alert_params
    params.require(:log_alert).permit(:machine_id, :addressee, :logger_type, :path, :arguments)
  end
end