#!/bin/sh

set -e

# Ensures the app's dependencies are installed.
mix deps.get

# Prepares Dialyzer if the project has it set up.
if mix help dialyzer >/dev/null 2>&1
then
  echo "\nFound Dialyxer: Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "\nNo Dialyxer config: Skipping setup..."
fi

# Installs JS libraries.
echo "\nInstalling JS..."
cd assets && npm install
cd ..

# Waits for Postgres to become available.
until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "\nPostgres is available: continuing with database setup..."

# Sets up the database.
mix ecto.create
mix ecto.migrate

# Runs the tests as a way to know whether the installation went OK or not.
echo "\nTesting the installation..."
mix test

# Starts the Phoenix web server.
echo "\n Launching Phoenix web server..."
mix phx.server
