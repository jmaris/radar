class HardwareController < ApplicationController # logic goes in this hardware_controller.rb file
    def status
        load_percentage = Sys::CPU.load_avg.first*100 / Sys::CPU.processors.count # should probably read from /proc
        render json: {  load: {
                            #"cpu_load_average":        Sys::CPU.load_avg,
                            "cpu":     load_percentage.round(2), #averaged to the last minute
                            "ram":     50,
                            "swap":    50,
                            "storage": 50
                            },
                            io: {
                                storage: {
                                    "in": 34.5,
                                    "out": 44
                                    },
                                net: {
                                    "in":  50,
                                    "out": 75
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
                                            "Total storage space": 549755813888
                                        }
                                        }
                                    }
                                end
                            end