
pardir=${PWD##*/}
pardir=${pardir:-/}
CALL_DIR=$(echo $pardir | tr '[:upper:]' '[:lower:]')  

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

grep -qxF "alias alpine-dev-env=\"$SCRIPT_DIR/alpine/build-img.sh\"" ~/.bash_aliases || echo -e "\nalias alpine-dev-env=\"$SCRIPT_DIR/alpine/build-img.sh\"" >> ~/.bash_aliases

grep -qxF "alias centos-dev-env=\"$SCRIPT_DIR/centos/build-img.sh\"" ~/.bash_aliases || echo -e "\nalias centos-dev-env=\"$SCRIPT_DIR/centos/build-img.sh\"" >> ~/.bash_aliases
