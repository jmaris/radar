class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy]

# def api_call
#   response = RestClient.get("#{@machine.protocol}://#{@machine.host}:#{@machine.port}/sonar_api_v1") #not very smart to hardcode the API version, but works for now.
#   hardware_load = JSON.parse(response)
# end

  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    #api_call
    api = Metric.api_call(@machine.protocol,@machine.host,@machine.port)
    @cpu_load   = api["load"]["cpu"]
    @ram_load   = api["load"]["ram"]
    @swap_load  = api["load"]["swap"]
    @hostname   = api["sysinfo"]["hostname"]
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
      params.require(:machine).permit(:protocol, :host, :port)
    end
end
