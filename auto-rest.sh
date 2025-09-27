#!/usr/bin/env bash
#===============================================================================
# Title:        Ansible Automation Script
# Author:       Paul Davis
# Description:  Automates 31 Ansible Scripts for RTX demo
# Notes: takes ~ 6 minutes to run
# netapp_demo.sh
# A simple sequence of Ansible playbooks to demo:
#   - NFS Export Policies & Rules
#   - Local Versioning (Snapshots) workflow
#   - Cluster User Management
#   - Logical Network Management
#===============================================================================
set -euo pipefail

# your lab-on-demand inventory
INV=./inventories/labondemand_9161

# helper: call one playbook (path WITHOUT .yml) under ./playbooks/
# Start total run timer
total_start_time=$(date +%s)

# helper: call one playbook (path WITHOUT .yml) under ./playbooks/
run_playbook () {
  local pb="$1"
  echo
  echo "======================================================"
  echo " Running playbook: playbooks/$pb.yml"
  echo "======================================================"

  # Start timer for individual playbook
  local start_time=$(date +%s)

  # Run the playbook
  ansible-playbook -i "$INV" "./playbooks/$pb.yml"

  # End timer for individual playbook
  local end_time=$(date +%s)

  # Calculate duration for individual playbook
  local duration=$((end_time - start_time))

  echo "Playbook $pb completed in $duration seconds."
}

# 1) Restore environment

run_playbook ONTAP-00/ONTAP-revert-00
run_playbook ONTAP-00/ONTAP-revert-00_linux
run_playbook ONTAP-00/ONTAP-revert-00_windows

# End total run timer
total_end_time=$(date +%s)

# Calculate total duration
total_duration=$((total_end_time - total_start_time))

echo
echo "=== Demo automation complete ==="
echo "Total run time: $total_duration seconds."
