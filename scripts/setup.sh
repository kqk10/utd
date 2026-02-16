#!/usr/bin/env bash

COMPOSE_FILE="compose.yaml"

generate_cmd() {
  cat <<'EOF'
su - training -c '
DEV1="${DEV1:-/home/training/training_materials/dev1}"
DEV1DATA="${DEV1DATA:-/home/training/training_materials/data}"
"${DEV1}/scripts/training_setup_dev1.sh"
hdfs dfs -mkdir /loudacre
cd "${DEV1DATA}"
hdfs dfs -put kb /loudacre/
hdfs dfs -ls /loudacre/kb
'
EOF
}

main() {
  docker compose -f "${COMPOSE_FILE}" exec cdh5 bash -c "$(generate_cmd)"
}

main
