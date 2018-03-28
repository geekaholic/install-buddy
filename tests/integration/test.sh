#!/bin/bash

# Script is meant to be run from within docker container as part of build process

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Thanks https://tuhrig.de/how-to-know-you-are-inside-a-docker-container/
awk -F/ '$2 == "docker"' /proc/self/cgroup | read
if [ $? -ne 0 ]; then
  echo  -e "${RED}Not running in a docker container{NC}\n"
  exit 1
fi

trap 'echo -e "\n${RED}Integration Test Failed!${NC}\n"'\
  HUP INT QUIT PIPE TERM

/app/bin/install-buddy -f /app/tests/integration/package-list.yml

if [ $? -ne 0 ]; then
  echo -e "\n${RED}Integration Test Failed!${NC}\n"
  exit 1
fi

echo -e "\n${GREEN} Integration Test passed${NC}\n"
exit 0
