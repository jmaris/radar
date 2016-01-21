class CpuController < ApplicationController
    def average_load
        Sys::CPU.load_avg.first
    end
end