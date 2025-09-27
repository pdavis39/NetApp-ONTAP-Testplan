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

# 1 Prep environment
run_playbook ONTAP-01/ONTAP-01-04

#2 Basic Cluster Configuration
run_playbook ONTAP-10/ONTAP-10-01
run_playbook ONTAP-10/ONTAP-10-02
run_playbook ONTAP-10/ONTAP-10-03
run_playbook ONTAP-10/ONTAP-10-04

#3 Advanced Cluster Configuration
run_playbook ONTAP-11/ONTAP-11-01
run_playbook ONTAP-11/ONTAP-11-02
run_playbook ONTAP-11/ONTAP-11-03

#4 Cluster User Management
run_playbook ONTAP-12/ONTAP-12-01
run_playbook ONTAP-12/ONTAP-12-02
run_playbook ONTAP-12/ONTAP-12-03
run_playbook ONTAP-12/ONTAP-12-04
run_playbook ONTAP-12/ONTAP-12-05
run_playbook ONTAP-12/ONTAP-12-06

# 5) Cluster Peering
run_playbook ONTAP-15/ONTAP-15-01
run_playbook ONTAP-15/ONTAP-15-02

#6 Basic SVM setup
run_playbook ONTAP-20/ONTAP-20-01
run_playbook ONTAP-20/ONTAP-20-02
run_playbook ONTAP-20/ONTAP-20-03
run_playbook ONTAP-20/ONTAP-20-04

#7 NFS 
run_playbook ONTAP-31/ONTAP-31-01
run_playbook ONTAP-31/ONTAP-31-02
run_playbook ONTAP-31/ONTAP-31-03
run_playbook ONTAP-31/ONTAP-31-04
run_playbook ONTAP-31/ONTAP-31-05

#8 Clonning NFS
run_playbook ONTAP-41/ONTAP-41-01
run_playbook ONTAP-41/ONTAP-41-02
run_playbook ONTAP-41/ONTAP-41-03
run_playbook ONTAP-41/ONTAP-41-04
run_playbook ONTAP-41/ONTAP-41-05

#9 Local Versioning Snapshots
run_playbook ONTAP-51/ONTAP-51-01
run_playbook ONTAP-51/ONTAP-51-02
run_playbook ONTAP-51/ONTAP-51-03

#9 Backup SnapMirror
run_playbook ONTAP-52/ONTAP-51-01
run_playbook ONTAP-52/ONTAP-52-02
run_playbook ONTAP-52/ONTAP-52-03
run_playbook ONTAP-52/ONTAP-52-04

# End total run timer
total_end_time=$(date +%s)

# Calculate total duration
total_duration=$((total_end_time - total_start_time))

echo
echo "=== Demo automation complete ==="
echo "Total run time: $total_duration seconds."
