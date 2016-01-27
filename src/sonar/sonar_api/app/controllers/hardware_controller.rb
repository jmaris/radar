class HardwareController < ApplicationController # logic goes in this hardware_controller.rb file
    def status
        load_percentage = Sys::CPU.load_avg.first*100 / Sys::CPU.processors.count # should probably read from /proc
        render json: { "cpu_load_average":     Sys::CPU.load_avg,
                       "cpu_load_percentage":  load_percentage.round(2), #this takes about 1 minute to be accurate4
                       "ram_load_percentage":  50 } #static RAM, not yet implemented
    end
end