#!/bin/bash

vms=($(virsh list --name --state-running))

for vm in "${vms[@]}"; do
    echo "IP addresses for $vm:"
    virsh domifaddr "$vm"
    echo "-----------------------------"
done
