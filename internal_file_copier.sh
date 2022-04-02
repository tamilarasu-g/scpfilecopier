#!/bin/bash

#Find the file with name  "hostname.pub"

HOSTNAME=$(hostname)

cat /root/.ssh/"${HOSTNAME}".pub

