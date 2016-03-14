class RamAlertsController < ApplicationController
  before_action :set_ram_alert, only: [:show, :edit, :update, :destroy]
  before_action :get_machines, only: [:edit, :new, :show, :create, :update]

  # GET /ram_alerts
  # GET /ram_alerts.json
  def index
    @ram_alerts = RamAlert.all
  end

  # GET /ram_alerts/1
  # GET /ram_alerts/1.json
  def show
  end

  # GET /ram_alerts/new
  def new
    @ram_alert = RamAlert.new
  end

  # GET /ram_alerts/1/edit
  def edit
  end

  # POST /ram_alerts
  # POST /ram_alerts.json
  def create
    @ram_alert = RamAlert.new(ram_alert_params)

    respond_to do |format|
      if @ram_alert.save
        flash[:success] = 'RAM Alert was successfully saved.'
        format.html { redirect_to ram_alerts_url }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /ram_alerts/1
  # PATCH/PUT /ram_alerts/1.json
  def update
    respond_to do |format|
      if @ram_alert.update(ram_alert_params)
        flash[:success] = 'RAM Alert was successfully updated.'
        format.html { redirect_to @ram_alert }
        format.json { render :show, status: :ok, location: @ram_alert }
      else
        format.html { render :edit }
        format.json { render json: @ram_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ram_alerts/1
  # DELETE /ram_alerts/1.json
  def destroy
    @ram_alert.destroy
    respond_to do |format|
      flash[:success] = 'RAM Alert was successfully destroyed.'
      format.html { redirect_to ram_alerts_url, notice: 'Ram alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ram_alert
      @ram_alert = RamAlert.find(params[:id])
    end

    def get_machines
      machines = Machine.all
      @machines_hash = {}
      machines.each do |machine|
        @machines_hash[machine.alias] = machine.id
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ram_alert_params
      params.require(:ram_alert).permit(:machine_id, :addressee, :threshold, :check_interval, :custom_message)
    end
end
