class CpuController < ApplicationController
    def average_load
        render json: Sys::CPU.load_avg.first
    end
end