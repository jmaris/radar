class HardwareController < ApplicationController # logic goes in this hardware_controller.rb file

    def live
        render json: {
            "cpu_percentage":   (Sys::CPU.load_avg.first*100 / Sys::CPU.processors.count).round(2), #cpu load averaged to the last minute
            "cpu_load_average": Sys::CPU.load_avg, # standard UNIX load average
            "ram_bytes":        Vmstat.memory.active_bytes,
            # "swap_bytes":       65435, # not yet implemented
            "storage_bytes":    (Sys::Filesystem.stat("/").blocks * Sys::Filesystem.stat("/").block_size) - Sys::Filesystem.stat("/").bytes_free, # this gives the used bytes
            "mountpoints":      Sys::Filesystem.mounts.map(&:mount_point),
            "uptime_seconds":   Sys::Uptime.seconds
        }
    end

    def sysinfo
        render json: {
            "hostname": Socket.gethostname,
            os: {
                "family": Sys::Uname.sysname,
                "release": Sys::Uname.release
            },
            cpu: {
                "model": Sys::CPU.processors.first.model_name,
                "cores": Sys::CPU.processors.count,
                "architecture": Sys::Uname.machine
            },
            ram: {
                "total_bytes": Vmstat.memory.total_bytes
            },
            # swap: {
            #     "total_bytes": 17179869184 # not yet implemented
            # },
            storage: {
                "total_bytes": (Sys::Filesystem.stat("/").blocks * Sys::Filesystem.stat("/").block_size)
            }
        }
    end
    
    def storage
        path = params[:path]
        render json:
        Sys::Filesystem.stat(path)
    end
end