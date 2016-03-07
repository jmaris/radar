Sonar
=========

<!-- [![Build Status](https://travis-ci.org/leoncastillejos/Sonar.svg?branch=master)](https://travis-ci.org/leoncastillejos/Sonar)
 -->
Repository hosting the Sonar project.

(For a less technical overview of the project, please visit [the project's webpage](https://leoncastillejos.github.io/sonar)).

To install, copy the sonar-api folder to the server you want to monitor, and the sonar_server folder to the server from which you will be monitoring. Define your hosts and go.

<!-- vvv Must be moved to the gh-pages branch vvv -->

## Characteristics

### Language

Most of the project will be written in Ruby, with Rails in order to dramatically speed up development, and since it's a web based implementation, it makes sense to use Rails.

# Progress

Work is divided in four stages, chronologically ordered.

## Stage 1: Planning

- Initial design
  - ~~Requirements~~
  - ~~Detailed scenario analysis~~
    - ~~Frameworks to use~~
    - ~~Languages to use~~
  - UI design (ongoing)

## Stage 2: Study
- ~~Viablity study~~

## Stage 3: Coding

- Software development (ongoing)

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
