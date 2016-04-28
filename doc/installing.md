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