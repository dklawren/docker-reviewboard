#!/bin/bash
docker run -d -t \
    --name reviewboard \
    --hostname reviewboard \
    --publish 8080:80 \
    --publish 2222:22 \
    dklawren/docker-reviewboard
