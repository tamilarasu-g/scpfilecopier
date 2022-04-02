#!/bin/bash

#Find the file with name  "hostname.pub"

HOSTNAME=$(hostname -s)

cat /root/.ssh/id_rsa_"${HOSTNAME}"_backupclient