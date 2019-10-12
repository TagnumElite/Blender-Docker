#!/usr/bin/env bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker tag tagnumelite/blender:develop "tagnumelite/blender:$TRAVIS_TAG"
docker push "tagnumelite/blender:$TRAVIS_TAG"
echo "$GITHUB_PASSWORD" | docker login docker.pkg.github.com -u TagnumElite --password-stdin
docker tag tagnumelite/blender:develop "docker.pkg.github.com/tagnumelite/blender-docker/blender:$TRAVIS_TAG"
docker push "docker.pkg.github.com/tagnumelite/blender-docker/blender:$TRAVIS_TAG"
