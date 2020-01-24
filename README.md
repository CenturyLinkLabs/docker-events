# Docker Event Stream

Containerized web application for monitoring the Docker event stream.

## NOTE

This repo is no longer being maintained. Users are welcome to fork it, but we make no warranty of its functionality.

## Usage

Since the application needs to interact with the Docker API in order to read
the event stream it needs access to the Docker API socket. When starting the
container, the `-v` flag needs to be used to make the Docker socket available
inside the container.

    docker run \
      -p 8080:4567 \
      -v /var/run/docker.sock:/var/run/docker.sock \
      centurylink/docker-events

It's also important to specify a port mapping so that the web application can be
accessed from outside the container. The web server running in the container
listens on port 4567. You can use either the `-p` flag to configure a specific
port mapping or the `-P` flag to have Docker assign a port dynamically.
