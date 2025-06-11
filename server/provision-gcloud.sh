#!/usr/bin/env bash
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

cd -P "$(dirname "${BASH_SOURCE[0]}")/.."

: "${SSH_COMMAND:="gcloud compute ssh"}"
: "${SCP_COMMAND:="gcloud compute scp"}"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [USER@]INSTANCE" >&2
  echo "" >&2
  echo "INSTANCE is typically the name of a Google Cloud VM (run 'gcloud compute instances list' to get a list)." >&2
  echo "" >&2
  echo "Examples:" >&2
  echo "  $0 entryapplication-web-dev" >&2
  exit 1
fi

# Copy the playbook
$SCP_COMMAND --verbosity=warning "server/playbook.yml" "$1":playbook.yml
# Install ansible and execute the playbook
$SSH_COMMAND --verbosity=warning "$1" --command="bash -c 'sudo apt install -y ansible && sudo ansible-playbook -v --connection=local --inventory=127.0.0.1, playbook.yml'"