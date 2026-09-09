#!/bin/bash

# network connection check script
# This script checks the network connection by pinging a specified host and reports if the connection is successful or not.
# Usage: ./network-check.sh <hostname-or-ip> [port]

REGEX_IP="^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
REGEX_HOSTNAME="^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <hostname-or-ip> [port]"
    exit 2
fi

host=$1

if [[ ! "$host" =~ $REGEX_IP ]] && [[ ! "$host" =~ $REGEX_HOSTNAME ]]; then
    echo "Error: Invalid hostname or IP address"
    exit 2
fi

port=${2:-80}

if [[ ! "$port" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a positive integer"
    exit 2
fi

if [[ "$port" -lt 1 ]] || [[ "$port" -gt 65535 ]]; then
    echo "Error: Port must be between 1 and 65535"
    exit 2
fi



echo "Nework Interface Check"
