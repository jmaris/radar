2 - Installing Sonar
====================

To install Sonar, it's required to have a Ruby on Rails installation. That means Sonar requires a Ruby interpreter as well as the Bundler package manager.

In this document, we'll cover how to install Ruby on Rails through the `rvm` installer on Linux. Mac OS X and Windows are not supported at this moment. There are also other ways to install Ruby on Rails that don't require `rvm`, but I chose it because it's the fastest, easiest and most widely known method of installing Ruby.

## Prerequisites

Only Arch Linux has been tested so far, but Ubuntu and Debian should work just as well.

This guide assumes you already have installed git and have the necessary knowledge to handle a commandline prompt.

For information on installing `rvm`, it's recommended to consult the [official website](https://rvm.io/). As of today (05/03/2016) these are the necessary steps to install it:

### Installing RVM

```bash
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable
```

### Installing Rails
```bash
$ gem install rails
```

### Downloading Sonar

```bash
$ git clone https://github.com/leoncastillejos/sonar.git
```

## Client / Server

Depending on the type of deployment you want to do, the above steps are common, but deploying a Sonar Web differs from deploying a Sonar API.

### Sonar Web (server)

Deploying a Sonar Web requires the server to be reachable from the Internet.

The server component will be located in `sonar/src/sonar/sonar_server`, so run:

```bash
$ cd sonar/src/sonar/sonar_server
```

`rake db:create` will create a database in SQLite. There are multiple guides available on the Internet if you want to use a different database.

`rake db:migrate` once the database has been setup, you can create the required tables.

`rake server` finally, to start the web server and have it listen on port 3000. If you want to have Sonar hosted on a different web server like Unicorn or Puma, you can search the Internet for guides.

### Sonar API (client)

A Sonar API deployment only requires it to be reachable from the Sonar Web server. Therefore, it's possible to set up firewall rules to restrict a Sonar API to only a specified IP.

The API component will be located at `sonar/src/sonar/sonar_api`, so run:

```bash
$ cd sonar/src/sonar/sonar_api
```

It is also recommended to open specific ports so that the server can talk to the client.

If opening ports is not possible or desirable for security reasons, you can set up an SSH tunnel with `auto-ssh` by following a guide like [this one](http://linuxaria.com/howto/permanent-ssh-tunnels-with-autossh).

Once the ports have been opened or the SSH tunnel has been set up, you can start Sonar API by running `rake server`.