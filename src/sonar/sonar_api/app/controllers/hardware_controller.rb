class HardwareController < ApplicationController # logic goes in this hardware_controller.rb file
    def status
        render json: {  load: {
                            "cpu_percentage":   (Sys::CPU.load_avg.first*100 / Sys::CPU.processors.count).round(2), #cpu load averaged to the last minute
                            "cpu_load_average": Sys::CPU.load_avg, # standard UNIX load average
                            "ram_bytes":        Vmstat.memory.active_bytes,
                            # "swap_bytes":       65435, # not yet implemented
                            "storage_bytes":    (Sys::Filesystem.stat("/").blocks * Sys::Filesystem.stat("/").block_size) - Sys::Filesystem.stat("/").bytes_free, # this gives the used bytes
                            "uptime_seconds":   Sys::Uptime.seconds
                            },
                            # io: { # not yet implemented
                            #     storage: {
                            #         "in":   34.5,
                            #         "out":  44
                            #         },
                            #     net: {
                            #         "in":   50,
                            #         "out":  75
                            #         }
                            #         },
                            sysinfo: {
                                "hostname": Socket.gethostname,
                                    os: {
                                        "Family": Sys::Uname.sysname,
                                        "Release": Sys::Uname.release
                                        },
                                    cpu: {
                                        "CPU model": Sys::CPU.processors.first.model_name,
                                        "Number of cores": Sys::CPU.processors.count,
                                        "Architecture": Sys::Uname.machine
                                        },
                                    ram: {
                                        "Total RAM bytes": 17179869184,
                                        "Total swap bytes": 17179869184
                                        },
                                    storage: {
                                        "Total storage bytes": (Sys::Filesystem.stat("/").blocks * Sys::Filesystem.stat("/").block_size)
                                    }
                                }
                            }
        end
    end