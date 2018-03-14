#!/bin/bash


##############
## Settings ##
##############
DOCKER_IMAGE="gradle:jdk8"
GRADLE_HOME_VOLUME="gradlehome"
GRADLE_CMD="clean test build makeDistDeleteable $SD_GRADLE_TASKS --console=plain $SD_GRADLE_OPTIONS"





#####################
## Build on Docker ##
#####################

#https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run -t --rm --name solideo-www-spring-builder \
 -v "$GRADLE_HOME_VOLUME":/home/gradle/.gradle -v "$DIR":/home/gradle/project \
 -u root \
 -w /home/gradle/project $DOCKER_IMAGE gradle $GRADLE_CMD \
 2>&1 | tee build.log

echo ""
echo ""



# Bug in gradle: Running as gradle user causes: Failed to load native library 
# 'libnative-platform.so' for Linux amd64. Fix: "-u root"
