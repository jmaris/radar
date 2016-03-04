class MountpointsController < ApplicationController
	def get
		machine_id = params[:machine_id]
		machine = Machine.find(machine_id)
		mountpoints = Machine.api(machine.protocol,machine.host,machine.port,"live")[:mountpoints]
		render json: {
			"mountpoints": mountpoints
		}
	end
end
