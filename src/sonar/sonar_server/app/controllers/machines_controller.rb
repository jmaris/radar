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
    #api_live
    api_live            = Metric.api(@machine.protocol,@machine.host,@machine.port,"live")
    api_sysinfo         = Metric.api(@machine.protocol,@machine.host,@machine.port,"sysinfo")
    @hostname           = api_sysinfo[:hostname]
    @cpu_load           = api_live[:cpu_percentage]
    @ram_load           = (api_live[:ram_bytes].to_f/api_sysinfo[:ram][:total_bytes].to_f*100).round(2)
    # @swap_load        = api_live[:swap] # swap not yet implemented
    @storage_bytes      = api_live[:storage_bytes]
    @uptime             = api_live[:uptime_seconds]
    # @cpu_load_last10    =
    # @ram_load_last10    =
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

    # api_sysinfo = Metric.api(@machine.protocol,@machine.host,@machine.port,"sysinfo")

    # @machine.hostname             = api_sysinfo[:hostname]
    # @machine.os                   = api_sysinfo[:os][:family]
    # @machine.cpu_model            = api_sysinfo[:cpu][:model]
    # @machine.cpu_cores            = api_sysinfo[:cpu][:cores]
    # @machine.cpu_architecture     = api_sysinfo[:cpu][:architecture]
    # @machine.ram_total_bytes      = api_sysinfo[:ram][:total_bytes]
    # @machine.storage_total_bytes  = api_sysinfo[:storage][:total_bytes]

    respond_to do |format|

      if @machine.save

        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
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
      format.html { redirect_to machines_url, notice: 'Machine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine ||= Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:protocol, :host, :port, :update_interval)
    end
  end
