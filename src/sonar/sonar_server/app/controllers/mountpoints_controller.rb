class MountpointsController < ApplicationController
	def get
		machine_id = params[:mountpoint][:_json]
		machine = Machine.find(machine_id)
		mountpoints = Machine.api(machine.protocol,machine.host,machine.port,"live")[:mountpoints]
		if request.post?
			render json: {
				"mountpoints": mountpoints
			}
		end
	end
end
