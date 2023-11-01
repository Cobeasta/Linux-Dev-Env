#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

if [[ "$1" == "alpine" ]]
  then
    cd alpine
elif [[ $1 == "ubuntu" ]]
  then cd ubuntu
elif [[ "$1" == "redhat" ]]
  then cd redhat
fi
docker-compose up -d --build

ssh builder@clion_docker -p 2222 && docker compose down

