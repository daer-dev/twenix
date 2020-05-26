FROM elixir:1.10.3

MAINTAINER Daniel Herrero <daniel.herrero.101@gmail.com>

# Installs Debian packages.
RUN apt-get update
RUN apt-get install --yes \
      build-essential \
      inotify-tools \
      postgresql-client

# Installs Phoenix and its dependencies.
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.5.3

# Installs NodeJS.
RUN curl -sL https://deb.nodesource.com/setup_14.x -o node_source_setup.sh
RUN bash node_source_setup.sh
RUN apt-get install nodejs

WORKDIR /app

EXPOSE 4000
