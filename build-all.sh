#!/bin/sh
set -e

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <USER_SSH_PRIVATE_KEY> <AWS_ACCESS_KEY> <AWS_SECRET_KEY>"
    exit 1
fi

USER_SSH_PRIVATE_KEY="$1"
AWS_ACCESS_KEY="$2"
AWS_SECRET_KEY="$3"

########## Cloud provision #######
./build-infra.sh ${AWS_ACCESS_KEY} ${AWS_SECRET_KEY}

############## Environment provision #########
sleep 40
./build-environment.sh ${USER_SSH_PRIVATE_KEY} ${AWS_ACCESS_KEY} ${AWS_SECRET_KEY}

exit 0