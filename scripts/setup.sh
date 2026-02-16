#!/usr/bin/env bash

COMPOSE_FILE="${PWD}/compose.yaml"
SETUP_SCRIPT="${DEV1}/scripts/training_setup_dev1.sh"

run_setup_script() {
  docker compose -f "${COMPOSE_FILE}" -c ""
}
