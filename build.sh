#!/usr/bin/env bash

# Usage: build.sh [output_directory [docker_image_name]]
set -e
# Parse the parameters
if [[ "xx" != "x${1}x" ]]; then
  OUTPUT_DIR="${1}"
else
  OUTPUT_DIR="./build"
fi

if [[ "xx" != "x${2}x" ]]; then
  DOCKER_IMAGE="${2}"
else
  DOCKER_IMAGE="readthedocs/build:ubuntu-24.04-2024.06.17"
fi

# Create the output directory
if [[ -e ${OUTPUT_DIR} ]]; then
  echo "Output directory already exists. Cleaning it up: ${OUTPUT_DIR}"
  rm -rf "${OUTPUT_DIR}"/*
else
  mkdir -p "${OUTPUT_DIR}"
fi

# Create a temporary directory for the output which is world writable
TEMP_BUILD_DIR=$(mktemp -d ${HOME}/rtfd_build_tempdir_XXXXXXXXXX)
trap "rm -rf ${TEMP_BUILD_DIR}" EXIT
chmod 2777 ${TEMP_BUILD_DIR}

# Build the documentation in a docker container
SCRIPT=$(cat <<EOF
umask 0002
apt install -y python3.12-venv
python3 -m venv ~/venv
source ~/venv/bin/activate
# modified to support the sphinx default theme and markdown
pip install sphinx recommonmark sphinx_rtd_theme
sphinx-build -b html /source/source/ /target/
EOF
)
pushd "$( dirname "${BASH_SOURCE[0]}" )"

# On Linux, add your user to the "docker" group [sudo usermod -aG docker $USER && newgrp docker] or use "sudo docker run ...".
# On macOS, no sudo is needed if Docker Desktop is running.

docker run --rm --volume "${PWD}:/source" --volume "${TEMP_BUILD_DIR}:/target" --user 0 "${DOCKER_IMAGE}" /bin/bash -c "${SCRIPT}"
popd

# Copy the output to the final output directory and remove the temporary one. This ensures that the files are owned by the correct user
cp -r "${TEMP_BUILD_DIR}" "${OUTPUT_DIR}"
rm -rf "${TEMP_BUILD_DIR}"

exit 0
