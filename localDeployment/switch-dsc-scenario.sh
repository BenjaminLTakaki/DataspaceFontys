#!/usr/bin/env bash
#
# Convenience wrapper for switching the native-k3s DSC demo scenario.
#
# Examples:
#   ./switch-dsc-scenario.sh local   --repo /path/to/data-space-connector --ip 172.20.10.15
#   ./switch-dsc-scenario.sh central --repo /path/to/data-space-connector --ip 172.20.10.15
#   ./switch-dsc-scenario.sh gaia-x  --repo /path/to/data-space-connector --ip 172.20.10.15
#   ./switch-dsc-scenario.sh elsi    --repo /path/to/data-space-connector --ip 172.20.10.15
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage:
  switch-dsc-scenario.sh <local|central|gaia-x|elsi|dsp> [prepare-native-k3s-server.sh options]

This deletes the DSC app namespaces before deployment, then runs the native
k3s prepare/deploy script with the matching Maven profiles.

Examples:
  ./switch-dsc-scenario.sh gaia-x --repo ~/data-space-connector --ip 172.20.10.15 --yes
  ./switch-dsc-scenario.sh central --repo ~/data-space-connector --skip-k3s-install --yes
EOF
}

if [[ $# -lt 1 || "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

SCENARIO="$1"
shift

exec "$SCRIPT_DIR/prepare-native-k3s-server.sh" \
  --scenario "$SCENARIO" \
  --reset-scenario \
  "$@"
