Installing Sonar
================

To install Sonar, it's required to have a Ruby on Rails installation. That means Sonar requires a Ruby interpreter as well as the Bundler package manager.

In this document, we'll cover how to install Ruby on Rails through the `rvm` installer on Linux. Mac OS X and Windows are not supported at this moment.

Only Arch Linux has been tested so far, but Ubuntu and Debian should work just as well.

1. Installing RVM

2. Installing Rails

3. Downloading Sonar

## Client / Server

Depending on the type of deployment you want to do, the above steps are common, but deploying a Sonar Web differs from deploying a Sonar API.

### Sonar Web (server)

Deploying a Sonar Web requires the server to be reachable from the Internet.

`rake db:create` will create a database. If you want to use something like PostgreSQL (recommended) instead of SQLite (the default for Sonar), you can xxx MISSING xxx

`rake db:migrate` once the database has been setup, you can create the required tables.

`rake server` finally, to start the web server and have it listen on port 3000. If you want to have Sonar hosted on a different web server like Unicorn or Puma, you can xxx MISSING xxx

## Sonar API (client)

A Sonar API deployment only requires it to be reachable from the Sonar Web server. Therefore, it's possible to set up firewall rules to restrict a Sonar API to only a specified IP.

It is also recommended to open specific ports so that the server can talk to the client.

If opening ports is not possible or desirable for security reasons, you can set up an SSH tunnel with `auto-ssh` like this:

xxx MISSING xxx

Once the ports have been opened or the SSH tunnel has been set up, you can start Sonar API by running `rake server`.