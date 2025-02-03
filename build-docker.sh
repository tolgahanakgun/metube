#!/bin/bash

set -e

pushd "$(dirname "$0")"

if [ "$1" = "--deploy" ]; then
    printf "Stopping current metube container ...\n"
    docker stop metube || true
    docker rm "$(docker ps -a -q  --filter ancestor=metube)" || true
    docker image rm metube || true
fi

docker build -t metube:latest .

if [ "$1" = "--deploy" ]; then
    printf "Starting the latest metube container ...\n"
    bash ../docker/metube
    # The `../docker/metube` file should contain sth like this:
    # docker run -d --name metube \
    # -e YT_DLP_UI_USER=your_user \
    # -e YT_DLP_UI_PASS=your_pass \
    # -v /downloads:/downloads metube
fi

popd
