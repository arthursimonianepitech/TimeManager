#!/bin/sh

mix ecto.create
mix ecto.migrate

mix run -e RolePreparator.prepare
mix run -e ViewPreparator.prepare

mix phx.server
