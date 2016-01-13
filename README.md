Sonar
=========

[![Build Status](https://travis-ci.org/leoncastillejos/Sonar.svg?branch=master)](https://travis-ci.org/leoncastillejos/Sonar)

Repository hosting the Sonar project.

(For a less technical overview of the project, please visit [the project's webpage](https://leoncastillejos.github.io/BdM-Sonar)).

## Characteristics

### Features

- Centralization of remote system administration
- Modular design
  - Input modules (I-Modules) (they feed Sonar with data about the hosts)  
  There are three kinds of I-Modules:
    - API modules
      - API modules read data from API servers.
      - API modules are two part modules. The first part is the server side, which is a piece of software designed to be run on the host to monitor, and the second part is the API reader, that is run on the machine hosting the Status Engine and acts as an interface.
    - Scan modules
      - These modules use the Sonar host to run a certain action on the remote host, such as ping, or establishing an SSH connection.
    - Shell modules
      - These modules open a shell in the remote host to run commands remotely, such as `apt-get update` or `sudo reboot`.
  - Output modules (O-modules)
    - They define the actions that must be taken when a new event is discovered.
    - O-Modules can ask the Status Engine to discriminate by event type, for example, for a mail module, we might only want to receive critical events, in order to avoid flooding the inbox.

### Goals
- Gather CPU, RAM, and HDD usage
- Ping hosts
- Execute commands on remote host
- Light footprint
- Configurable alerts
- Web UI
- Flexible
- Scalable
- Secure

### Software details

#### Language

Most of the project will be written in Ruby, with Rails in order to dramatically speed up development, and since it's a web based implementation, it makes sense to use Rails.

#### Why modular?

I chose a modular design to make the core logic as small as possible. Less code, usually means less bugs.  
Small codebase means it's also easier to review for potential security threats.  
It also means the Status Engine can be potentially reimplemented in a different language (maybe to support exotic hardware).  
It makes sense, in such a scenario, to separate the application's logic from the tests and the output, rather than trying to bake all the functionality into a single package (each company has their own needs, and by removing unnecessary modules, the software package gets easier to maintain, more reliable and secure).  
TL;DR: Less is more. Flexibility is essential.

# Progress

Work is divided in four stages, chronologically ordered.

## Stage 1: Planning

- Initial design
  - ~~Requirements~~
  - ~~Detailed scenario analysis~~
    - ~~Frameworks to use~~
    - ~~Languages to use~~
  - UI design (ongoing)
  - Implementation network map (ongoing)

## Stage 2: Study
- Viablity study
- Create a tiny Status Engine to handle I-Module messages
- Create simple bash I-Module for pinging hosts

## Stage 3: Coding

- Software development
  - Finish status Engine
  - Module framework implementation
  - Modules
    - I-Modules
      - Ping
      - CPU
      - RAM
      - HDD usage
    - O-Modules
      - Plaintext logging
      - Pushover mobile notifications
      - SMS notifications
      - E-mail notifications

## Stage 4: Implementation

- Compile software from source in production server
- Execute software in production server
- Create installation packages for Debian and Arch (through the AUR)

# BdM Implementation goals
Since this is a project developed for Bufete de Marketing, this will be the main software implementation. However, Sonar is flexible enough to be implemented  in different scenarios.
- Hardware requirements
  - ~~DigitalOcean's 5$ (512 MB RAM) VPS (it's very, very affordable, and, if needed, it's possible to leverage DO's infrastructure to get a bigger, faster VPS).~~
- Software details
  - The **web interface** will be written in Rails, using Ruby. Thanks to the flexibility of Ruby, its Object-Oriented style and the generally big community, it should make development very fast and elegant, while opening up the possibilities for future extensions.