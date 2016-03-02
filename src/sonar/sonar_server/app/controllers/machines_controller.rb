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
    api_live = Machine.api(@machine.protocol,@machine.host,@machine.port,"live")
    api_sysinfo = Machine.api(@machine.protocol,@machine.host,@machine.port,"sysinfo")
    @status               = false
    @status               = true if Machine.api(@machine.protocol,@machine.host,@machine.port,"live")
    @alias                = @machine.alias
    ###### API access
    # @hostname             = api_sysinfo[:hostname]
    # @cpu_load             = api_live[:cpu_percentage]
    # @ram_load             = (api_live[:ram_bytes].to_f/api_sysinfo[:ram][:total_bytes].to_f*100).round(2)
    # @storage_load         = StorageMetric.where(machine_id = @machine.id).last.storage
    # # @swap_load          = api_live[:swap] # swap not yet implemented
    # @storage_bytes        = api_sysinfo[:storage][:total_bytes]
    ###### endof API access
    @hostname             = @machine.hostname
    @cpu_load             = CpuMetric.where(machine_id = @machine.id).last.cpu
    @ram_load             = RamMetric.where(machine_id = @machine.id).last.ram
    @storage_load         = StorageMetric.where(machine_id = @machine.id).last.storage
    @storage_bytes        = @machine.storage_total_bytes
    # @uptime               = api_live[:uptime_seconds]
    @update_interval      = @machine.update_interval
    @cpu_load_last10      = CpuMetric.where(machine_id: @machine.id).last(10).map(&:cpu) # short for CpuMetric.where(machine_id: 3).last(10).map {|cpu_metric| cpu_metric.cpu}
    @ram_load_last10      = RamMetric.where(machine_id: @machine.id).last(10).map(&:ram)
    @storage_load_last10  = StorageMetric.where(machine_id: @machine.id).last(10).map(&:storage)
    # @swap_load_last10   = 
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
        format.js
      else
        flash[:danger] = 'There was a problem creating the Machine.'
        format.html { render :new }
        format.js
      end
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
        flash[:danger] = 'There was a problem updating the Machine.'
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
      format.html { redirect_to machines_url}
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
      params.require(:machine).permit(:alias, :protocol, :host, :port, :update_interval)
    end
  end
