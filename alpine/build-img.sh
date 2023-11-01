
pardir=${PWD##*/}
pardir=${pardir:-/}
CALL_DIR=$(echo $pardir | tr '[:upper:]' '[:lower:]')

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker build -t "c-dev-env-alpine" --build-arg=$(id -u) -f "$SCRIPT_DIR/dockerfile.alpine" $SCRIPT_DIR 

echo "starting"
docker run -dit --rm -p127.0.0.1:2222:22 --mount type=bind,source=//$(pwd),destination=//"/home/builder/$CALL_DIR" --name="c-dev-env-alpine" c-dev-env-alpine

ssh builder@clion_docker -p2222 && docker stop "c-dev-env-alpine"