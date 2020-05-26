#!/bin/sh

set -e

# Ensures the app's dependencies are installed.
mix deps.get

# Prepares Dialyzer if the project has it set up.
if mix help dialyzer >/dev/null 2>&1
then
  echo "\n Dialyxer config found. Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "\n No Dialyxer config found. Skipping setup..."
fi

echo "\n Installing JS libraries..."
cd assets && npm install
cd ..

echo "\n Setting up the database..."
mix ecto.create
mix ecto.migrate

# Runs the tests as a way to know whether the installation went OK or not.
echo "\n Testing the installation..."
mix test

echo "\n Launching Phoenix web server..."
mix phx.server
