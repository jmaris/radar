BdM-Sonar
=========
Repository hosting the Sonar project for Bufete de Marketing.

## What is Sonar?
Sonar is an advanced open source service and server monitoring tool designed to be extremely modular, light (both in installation size and in resources consumed, while still providing a framework for plugins).

### Why? Isn't this similar to XXX, YYY and ZZZ?
While similar software exists, there is no major software implementation that was built from the ground up to be modular. Most monitoring tools offer an embedded web server that is usually ugly and not designed to be extensively modified. There is also no implementation that supports a standalone mode (no webserver or GUI) and a GUI mode that can be started simultaneously or alternatively.  
Sonar's Status Engine (the core logic) is designed to be run as a daemon or periodically, so that it doesn't constantly consume system resources.  
Sonar's goal is to also be really light on resources, meaning that the actual system load will be the input and output plugins and not the daemon itself, making it that much easier to optimize the infrastructure to suit low power machines.  
Non-exahustive list of service and server monitoring software:
- [htop](http://hisham.hm/htop/ "htop")
- [Nagios](https://www.nagios.com/solutions/linux-service-monitoring "Nagios")
- [Zabbix](http://www.zabbix.com/ "Zabbix")
- [Munin](http://munin-monitoring.org/ "Munin")
- [Cacti](http://www.cacti.net/ "Cacti")
- [Icinga](https://www.icinga.org "Icinga")
- [SmokePing](http://oss.oetiker.ch/smokeping/ "SmokePing")


### Why the silly name?
The idea behind Sonar is to have a central service (Status Engine) that periodically polls whatever the input plugins provide (services, servers, IoT devices, or basically almost anything with a network connection), it's designed to do periodic and sequential queries (like a ship's Sonar) to each of the elements provided by input plugins, so it works very similar to actual Sonar systems, since it doesn't need a service to be running on the target host, while it can still exahustively scan it. It also sounds cool :smile:.

### Where does the idea come from?
Sonar is the final-year project for the 2015-2016 course I'm currently studying.

## Features
- Sonar will be designed to have a small footprint to be easy to maintain, understand, modify, and extend.
- The essential part of Sonar is the Status Engine, and Sonar itself won't force any actual dependencies beyond the Status Engine. However, Sonar will connect Input Plugins with Output Plugins, but the I/O logic is managed by the plugins themselves.
- Modulable design, using plugins
  - Input plugins (I-Plugins)
    - They provide elements and entities to the Status Engine. **Elements** are each of the services running on every machine. **Entities** are the way elements are grouped, each entity represents a network host.
    - Input plugins will provide tests to perform, and the conditions required to fail the tests (for example, a plugin that queries a server farm might prefer to first query the datacenter link and immediately fail in case of datacenter link error, instead of individually checking each server in the farm).
  - Output plugins (O-Plugins)
    - They define the actions that must be taken when a new event is discovered.
    - O-Plugins can ask the Status Engine to discriminate by event type, for example, for a mail plugin, we might only want to receive critical events, in order to avoid flooding the inbox, while a webserver daemon plugin might want to receive each and every one of the events, so that they can be correctly archived and managed, so that graphs can be generated for the user to display important statistical information.

## Main implementation goals 
- Sonar will be ran in a separate server, so that it's not prone to company servers' failures.

## Milestones
- Status Engine
- Plugin framework implementation
- Plugins
  - I-Plugins
    - General host ping
    - General TCP service check
    - SSH
    - RabbitMQ
    - ElasticSearch
    - PostgreSQL
    - Rails
    - RDP
    - IMAP
    - SMTP
    - POP3
    - HTTP(S)
    - AWS API
    - DigitalOcean API
  - O-Plugins
    - Ruby on Rails Web UI
    - Plaintext logging
    - REST API
    - JSON output
    - Pushover mobile notifications
    - SMS notifications
    - E-mail notifications