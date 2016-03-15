# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Machine.create(protocol: "http", host: "localhost", port: "4963", update_interval: 1, alias: "pc-test-localhost")
Machine.create(protocol: "http", host: "127.0.0.1", port: "4963", update_interval: 1, alias: "pc-test-127.0.0.1")