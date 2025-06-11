#!/usr/bin/env bash
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

cd -P "$(dirname "${BASH_SOURCE[0]}")"

# Start Vagrant VM if needed
vm_status="$(vagrant status --machine-readable default | awk -F, '$3 == "state" { print $4 }')"
if [ "$vm_status" != "running" ]; then
  echo "Vagrant VM status is '${vm_status}'. Running 'vagrant up'..." >&2
  vagrant up --provision
fi

mkdir -p "$HOME/.ssh"
if test -f "$HOME/.ssh/agent.env"; then
  source "$HOME/.ssh/agent.env"
fi

# Start SSH agent if needed
agent_state="$(ssh-add -l >/dev/null 2>&1; echo "$?")"
if [ "$agent_state" -eq 2 ]; then
  # Agent not running at all
  eval "$(ssh-agent -s | tee "$HOME/.ssh/agent.env")"
  ssh-add
elif [ "$agent_state" -eq 1 ]; then
  # Agent running but no keys
  ssh-add
fi

# With everything setup, delegate to `vagrant ssh`
exec vagrant ssh -- "$@"