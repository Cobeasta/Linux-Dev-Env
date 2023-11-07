

pardir=${PWD##*/}
pardir=${pardir:-/}
CALL_DIR=$(echo $pardir | tr '[:upper:]' '[:lower:]')  

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

grep -qxF "alias alpine-dev-env=\"$SCRIPT_DIR/alpine/build-img.sh\"" ~/.bash_aliases || echo -e "\nalias alpine-dev-env=\"$SCRIPT_DIR/alpine/build-img.sh\"" >> ~/.bash_aliases



source $SCRIPT_DIR/centos/config
echo $CENTOS_ENV_NAME

IFS='' read -r -d '' CENTOS_SSHCONFIGENTRY <<EOF
Host ${CENTOS_ENV_NAME}
        HostName ${CENTOS_ENV_NAME}
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
        GlobalKnownHostsFile /dev/null
        User ${CENTOS_USERNAME}
        Port ${CENTOS_PORTMOUNT}
EOF
echo "check for ${CENTOS_ENV_NAME} ssh config host entry"
# Check for dev environment
grep -xF "Host ${CENTOS_ENV_NAME}" ~/.ssh/config

if [ $? -ne 0 ]; then
        echo "Writing SSH config host entry for ${CENTOS_ENV_NAME} environment"
        echo -e "\n$CENTOS_SSHCONFIGENTRY" >> ~/.ssh/config 
fi

grep -qxF "alias $CENTOS_ENV_NAME=\"$SCRIPT_DIR/centos/build-img.sh\"" ~/.bash_aliases || echo -e "\nalias ${CENTOS_ENV_NAME}=\"$SCRIPT_DIR/centos/build-img.sh\"" >> ~/.bash_aliases


