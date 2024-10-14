#!/usr/bin/bash

# Required because the authorized_keys file has some garbage in the first line, for some reason
cat .ssh/id_rsa.pub > .ssh/authorized_keys
