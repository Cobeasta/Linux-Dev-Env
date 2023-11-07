PORTMOUNT=4444
pardir=${PWD##*/}
pardir=${pardir:-/}
CALL_DIR=$(echo $pardir | tr '[:upper:]' '[:lower:]')

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker build -t "dev-env-centos" --build-arg=$(id -u) -f "$SCRIPT_DIR/dockerfile.centos" $SCRIPT_DIR 

echo "starting"
docker run -dit --rm -p127.0.0.1:$PORTMOUNT:22 --mount type=bind,source=//$(pwd),destination=//"/home/builder/$CALL_DIR" --name="dev-env-centos" dev-env-centos

ssh user@clion_docker -p$PORTMOUNT && docker stop "dev-env-centos"