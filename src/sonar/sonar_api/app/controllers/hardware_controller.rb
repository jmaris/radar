class HardwareController < ApplicationController # logic goes in this hardware_controller.rb file
    def cpu
        load_percentage = Sys::CPU.load_avg.first*100 / Sys::CPU.processors.count # should probably read from /proc
        render json: { "load_average":     Sys::CPU.load_avg,
                       "load_percentage":  load_percentage.round(2) } 
    end
    def memory
        render text: "not actual RAM, static"
    end
    def storage
        render text: "not actual storage, static"
    end
    def network
        render text: "not actual network, static"
    end
end