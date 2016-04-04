class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy]

  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    @alias                = @machine.alias
    @storage_bytes        = @machine.storage_total_bytes
    @update_interval      = @machine.update_interval
    @status               = false
    @status               = true unless Machine.api(@machine.protocol, @machine.host, @machine.port, 'live') == 'error'
    if @status
      api_live              = Machine.api(@machine.protocol, @machine.host, @machine.port, 'live')
      api_sysinfo           = Machine.api(@machine.protocol, @machine.host, @machine.port, 'sysinfo')
      @hostname             = api_sysinfo[:hostname]
      @cpu_load             = api_live[:cpu_percentage]
      @ram_load             = (api_live[:ram_bytes].to_f/api_sysinfo[:ram][:total_bytes].to_f * 100).round(2)
      # @swap_load            = api_live[:swap] # swap not yet implemented
      @storage_load         = (api_live[:storage_bytes].to_f/api_sysinfo[:storage][:total_bytes].to_f * 100).round(2) # we should be calling the API for this
      @uptime               = api_live[:uptime_seconds]
    end
    @chart_names          = ["CPU", "RAM", "Storage"]

    # @cpu_load_last10 = Hash.new
    # @cpu_load_last10["2016-04-04 09:38:20"] = 15
    # @cpu_load_last10["2016-04-04 09:39:20"] = 45
    # @cpu_load_last10["2016-04-04 09:45:20"] = 58

    @cpu

    @cpu_load_last10      = Hash[CpuMetric.where(machine_id: @machine.id).last(100).map {|m| [m.created_at, m.cpu] }]
    @ram_load_last10      = Hash[RamMetric.where(machine_id: @machine.id).last(100).map {|m| [m.created_at, m.ram] }]
    @storage_load_last10  = Hash[StorageMetric.where(machine_id: @machine.id).last(100).map {|m| [m.created_at, m.storage] }]
  end

  # GET /machines/new
  def new
    @machine = Machine.new
  end

  # GET /machines/1/edit
  def edit
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save
        flash[:success] = 'Machine was successfully saved.'
        format.html { redirect_to machines_url }
      else
        format.html { render :new }
      end
      format.js
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        flash[:success] = 'Machine was successfully updated.'
        format.html { redirect_to @machine }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine.destroy
    respond_to do |format|
      flash[:success] = 'Machine was successfully destroyed.'
      format.html { redirect_to machines_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_machine
    @machine ||= Machine.find(params[:id])
  end

  # Never trust parameters from the internet, only allow the white list through.
  def machine_params
    params.require(:machine).permit(:alias, :protocol, :host, :port,:update_interval)
  end
end
