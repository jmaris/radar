BdM-Sonar
=========
Repository hosting the Sonar project for Bufete de Marketing.

(For a less technical overview of the project, please visit [the project's webpage](https://leoncastillejos.github.io/BdM-Sonar)).

## Features
- Centralization of remote system administration
- Light footprint
- Configurable instant alerts
- Support for multiple user interfaces (or even pure CLI with config files!)
- Support for running it periodically instead of as a daemon
- The essential part of Sonar is the Status Engine, and Sonar itself won't force any actual dependencies beyond the Status Engine
- The status engine will be written in [Rust](https://cburgdorf.wordpress.com/2014/07/17/rust-will-be-the-language-of-the-future/), a fast, safe, concurrent language
- Modulable design, using plug-ins
  - Input plug-ins (Iplug-ins)
    - They provide elements and entities to the Status Engine. **Elements** are each of the services running on every machine. **Entities** are the way elements are grouped, each entity represents a network host.
    - Input plug-ins will provide tests to perform, and the conditions required to fail the tests (for example, a plug-in that queries a server farm might prefer to first query the datacenter link and immediately fail in case of datacenter link error, instead of individually checking each server in the farm).
  - Output plug-ins (Oplug-ins)
    - They define the actions that must be taken when a new event is discovered.
    - O-plug-ins can ask the Status Engine to discriminate by event type, for example, for a mail plug-in, we might only want to receive critical events, in order to avoid flooding the inbox, while a webserver daemon plug-in might want to receive each and every one of the events, so that they can be correctly archived and managed, so that graphs can be generated for the user to display important statistical information.

# BdM Implementation goals
Since this is a project developed for Bufete de Marketing, this will be the main software implementation. However, Sonar is flexible enough to be implemented  in different scenarios.
- Hardware requirements
  - DigitalOcean's 5$ (512 MB RAM) VPS (it's very, very affordable, and, if needed, it's possible to leverage DO's infrastructure to get a bigger, faster VPS).
- Software details
  - The **web interface** (developed as an OPlug-in) will be written in Rails, using Ruby. Thanks to the flexibility of Ruby, its Object-Oriented style and the generally big community, it should make development very fast and elegant, while opening up the possibilities for future extensions.
  - The IPlug-ins can be written in almost any language, even scripting languages such as bash. In the very early stages of development, this will most likely be the case, to be able to quickly start testing the system. Later on, this can be changed to Ruby, C, or even Rust, too!

# Progress
- Initial design
  - ~~Requiriments~~
  - ~~Detailed scenario analysis~~
    - ~~Frameworks to use~~
    - ~~Languages to use~~
  - UI design (ongoing)
- Software development
  - Status Engine
  - Plug-in framework implementation
  - Plug-ins
    - IPlug-ins
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
    - OPlug-ins
      - Ruby on Rails Web UI
      - Plaintext logging
      - REST API
      - JSON output
      - Pushover mobile notifications
      - SMS notifications
      - E-mail notifications