#!/bin/bash

target_ip="127.0.0.1"
target_port="9500"

nc -z -v $target_ip $target_port 2>&1 | grep -q 'succeeded'

if [ $? -eq 0 ]; then
  echo "Port $target_port on $target_ip is open."
  exit 0
else
  echo "Port $target_port on $target_ip is closed or unreachable."
  exit 1
fi
