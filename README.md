Sonar
=========
Repository hosting the Sonar project.

(For a less technical overview of the project, please visit [the project's webpage](https://leoncastillejos.github.io/BdM-Sonar)).

## Characteristics

### Features

- Centralization of remote system administration
- Support for multiple user interfaces through I-Modules
- Status Engine written in Rust
- No modules are mandatory
- Modular design
  - Input modules (I-Modules)
    - They provide elements and entities to the Status Engine. **Elements** are each of the services running on every machine. **Entities** are the way elements are grouped, each entity represents a network host.
    - Input modules will provide tests to perform, and the conditions required to fail the tests (for example, a module that queries a server farm might prefer to first query the datacenter link and immediately fail in case of datacenter link error, instead of individually checking each server in the farm).
  - Output modules (O-modules)
    - They define the actions that must be taken when a new event is discovered.
    - O-Modules can ask the Status Engine to discriminate by event type, for example, for a mail module, we might only want to receive critical events, in order to avoid flooding the inbox, while a webserver daemon module might want to receive each and every one of the events, so that they can be correctly archived and managed, so that graphs can be generated for the user to display important statistical information.

### Goals
- Light footprint
- Support for running it periodically instead of as a daemon
- Configurable instant alerts
- Web UI
- Flexible

### Why Rust?
See [this](https://cburgdorf.wordpress.com/2014/07/17/rust-will-be-the-language-of-the-future/).

Rust is  low level like C, fast like C++, and features a high level syntax like Ruby or Java. Requires no garbage collector.  
Rust generates binary applications, as opposed to the interpreted code Ruby uses. This gives it an advantage in speed.  
The idea is for the Status Engine to be as tiny as possible, so that no modifications to the source are necessary in order to adapt it for a specific scenario.

TL;DR: Rust is a modern, fast, safe and concurrent language.

### Why modular?

I chose a modular design to make the core logic as small as possible. Less code, usually means less bugs.  
Small codebase means it's also easier to review for potential security threats.  
It also means the Status Engine can be potentially reimplemented in a different language (maybe to support exotic hardware).  
It makes sense, in such a scenario, to separate the application's logic from the tests and the output, rather than trying to bake all the functionality into a single package (each company has their own needs, and by removing unnecessary modules, the software package gets easier to maintain, more reliable and secure).  
The Status Engine can also enforce strict security policies in ways that don't get exposed to modules: From authentication, to encrypting and decrypting data, signing and verifying, etc. This way, unauthorized users are blocked from potentially accessing sensitive information about the environment structure, etc.

TL;DR: Less is more. Flexibility is essential.

# Progress

## Stage 1: Planning

- Initial design
  - ~~Requirements~~
  - ~~Detailed scenario analysis~~
    - ~~Frameworks to use~~
    - ~~Languages to use~~
  - UI design (ongoing)
  - Implementation network map (ongoing)

Stage 2:
- 

## Stage 3: Coding

- Software development
  - Status Engine
  - Module framework implementation
  - Modules
    - I-Modules
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
    - O-Modules
      - Ruby on Rails Web UI
      - Plaintext logging
      - REST API
      - JSON output
      - Pushover mobile notifications
      - SMS notifications
      - E-mail notifications

# BdM Implementation goals
Since this is a project developed for Bufete de Marketing, this will be the main software implementation. However, Sonar is flexible enough to be implemented  in different scenarios.
- Hardware requirements
  - DigitalOcean's 5$ (512 MB RAM) VPS (it's very, very affordable, and, if needed, it's possible to leverage DO's infrastructure to get a bigger, faster VPS).
- Software details
  - The **web interface** (developed as an O-Module) will be written in Rails, using Ruby. Thanks to the flexibility of Ruby, its Object-Oriented style and the generally big community, it should make development very fast and elegant, while opening up the possibilities for future extensions.
  - The I-Modules can be written in almost any language, even scripting languages such as bash. In the very early stages of development, this will most likely be the case, to be able to quickly start testing the system. Later on, this can be changed to Ruby, C, or even Rust, too!
