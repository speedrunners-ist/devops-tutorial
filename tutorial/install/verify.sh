#!/usr/bin/bash

# Checking if the uwsgi-piku service is running
# exit with 1 if it is not
if ! systemctl is-active --quiet uwsgi-piku; then
  exit 1
fi