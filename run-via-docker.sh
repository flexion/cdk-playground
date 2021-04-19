#!/bin/bash
# A script to start a Docker image, passing existing AWS credentials, and pass a command to the image

# Obtain the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ $# -eq 0 ]; then
    echo "Please pass this script a command to run within the docker container."
    exit 1
fi

# Confirm aws can run
# aws sts get-caller-identity --query Account --output text >/dev/null 2>&1
# if [ $? -ne 0 ]; then
#     echo "It does not appear you have AWS credentials set up.  Please set up AWS credentials and re-run this script."
#     exit 1
# fi


DOCKER_ENV=""
for VAR in $(printenv | egrep -e '^AWS_'); do
  DOCKER_ENV="-e ${VAR} ${DOCKER_ENV}"
done

echo "Running the passed in command:"
echo "$@"
echo "in the devops docker container"
if [ -t 0 ] ; then
  echo "stdin is a terminal, running interactively"
  TERM_ARGS="-it"
else
  echo "stdin is not a terminal, not running interactively"
  TERM_ARGS=""
fi
docker run ${DOCKER_ENV} ${TERM_ARGS} \
  -v "${PWD}":/cdktf-workspace \
  -v "${HOME}/.aws":/root/.aws \
  cdktf /bin/bash -c "$@"
