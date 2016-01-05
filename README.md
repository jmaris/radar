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
- Modulable design, using plug-ins
  - Input plug-ins (Iplug-ins)
    - They provide elements and entities to the Status Engine. **Elements** are each of the services running on every machine. **Entities** are the way elements are grouped, each entity represents a network host.
    - Input plug-ins will provide tests to perform, and the conditions required to fail the tests (for example, a plug-in that queries a server farm might prefer to first query the datacenter link and immediately fail in case of datacenter link error, instead of individually checking each server in the farm).
  - Output plug-ins (Oplug-ins)
    - They define the actions that must be taken when a new event is discovered.
    - O-plug-ins can ask the Status Engine to discriminate by event type, for example, for a mail plug-in, we might only want to receive critical events, in order to avoid flooding the inbox, while a webserver daemon plug-in might want to receive each and every one of the events, so that they can be correctly archived and managed, so that graphs can be generated for the user to display important statistical information.

## Main implementation goals 
- Sonar will be ran in a separate server, so that it's not prone to company servers' failures.

## Milestones
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