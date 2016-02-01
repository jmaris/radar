class HardwareController < ApplicationController # logic goes in this hardware_controller.rb file
    def status
        render json: {  load: {
                            "cpu_percentage":   (Sys::CPU.load_avg.first*100 / Sys::CPU.processors.count).round(2), #averaged to the last minute
                            "cpu_load_average": Sys::CPU.load_avg,
                            "ram":              50456456,
                            "swap":             65435,
                            "storage_bytes":    Sys::Filesystem.stat("/").bytes_free
                            },
                            io: {
                                storage: {
                                    "in":   34.5,
                                    "out":  44
                                    },
                                net: {
                                    "in":   50,
                                    "out":  75
                                    }
                                    },
                            sysinfo: {
                                "hostname": Socket.gethostname,
                                        cpu: {
                                            "CPU model": "Intel i7 5694K",
                                            "Number of cores": Sys::CPU.processors.count
                                            },
                                        ram: {
                                            "Total RAM": 17179869184,
                                            "Total swap space": 17179869184
                                            },
                                        storage: {
                                            "Total storage space": (Sys::Filesystem.stat("/").blocks * Sys::Filesystem.stat("/").block_size)
                                        }
                                        }
                                    }
                                end
                            end