class CpuAlertsController < ApplicationController
  before_action :set_cpu_alert, only: [:show, :edit, :update, :destroy]

  # GET /cpu_alerts
  # GET /cpu_alerts.json
  def index
    @cpu_alerts = CpuAlert.all
  end

  # GET /cpu_alerts/1
  # GET /cpu_alerts/1.json
  def show
  end

  # GET /cpu_alerts/new
  def new
    @cpu_alert = CpuAlert.new
  end

  # GET /cpu_alerts/1/edit
  def edit
  end

  # POST /cpu_alerts
  # POST /cpu_alerts.json
  def create
    @cpu_alert = CpuAlert.new(cpu_alert_params)

    respond_to do |format|
      if @cpu_alert.save
        format.html { redirect_to @cpu_alert, notice: 'Cpu alert was successfully created.' }
        format.json { render :show, status: :created, location: @cpu_alert }
      else
        format.html { render :new }
        format.json { render json: @cpu_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpu_alerts/1
  # PATCH/PUT /cpu_alerts/1.json
  def update
    respond_to do |format|
      if @cpu_alert.update(cpu_alert_params)
        format.html { redirect_to @cpu_alert, notice: 'Cpu alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpu_alert }
      else
        format.html { render :edit }
        format.json { render json: @cpu_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpu_alerts/1
  # DELETE /cpu_alerts/1.json
  def destroy
    @cpu_alert.destroy
    respond_to do |format|
      format.html { redirect_to cpu_alerts_url, notice: 'Cpu alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpu_alert
      @cpu_alert = CpuAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpu_alert_params
      params.require(:cpu_alert).permit(:machine_id, :addressee, :cpu_threshold, :check_interval)
    end
end
