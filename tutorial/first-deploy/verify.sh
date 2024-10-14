#!/bin/bash

# Define the target IP address and port
target_ip="127.0.0.1"  # Change this to your target IP
target_port="4000"      # Change this to your target port

# Check if the port is open using nc (netcat)
nc -z -v $target_ip $target_port 2>&1 | grep -q 'succeeded'

# Check the exit status of the last command
if [ $? -eq 0 ]; then
  echo "Port $target_port on $target_ip is open."
  exit 0
else
  echo "Port $target_port on $target_ip is closed or unreachable."
  exit 1
fi
