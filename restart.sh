#!/usr/bin/env bash

docker compose rm -fs redu && \
  docker compose rm -fs redu && \
  sudo rm -f tmp/pids/server.pid && \
  docker compose up -d redu && \
  docker compose logs -f redu
