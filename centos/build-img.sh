ENV_OS="centos"

# Get caller's parent directory 
pardir=${PWD##*/}
pardir=${pardir:-/}
CALL_DIR=$(echo $pardir | tr '[:upper:]' '[:lower:]')

# Get directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get parameters
source "$SCRIPT_DIR/config"
echo "Building docker image for ${CENTOS_ENV_NAME}"

docker build -t "${CENTOS_ENV_NAME}" --build-arg=$(id -u) -f "${SCRIPT_DIR}/${CENTOS_DOCKERFILE_NAME}" $SCRIPT_DIR 



echo "starting $ENV_NAME docker container"

docker run -dit --rm -p127.0.0.1:$CENTOS_PORTMOUNT:22 --mount type=bind,source=//$(pwd),destination=//"/home/${CENTOS_USERNAME}/$CALL_DIR" --name="${CENTOS_ENV_NAME}" $CENTOS_ENV_NAME

ssh ${CENTOS_SSHHOSTENTRYNAME} && docker stop "$CENTOS_ENV_NAME"