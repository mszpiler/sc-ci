#!/usr/bin/env bash

set -e

# Export the active docker machine IP
export DOCKER_IP=$(docker-machine ip $(docker-machine active))

echo -e "\n\e[32mStopping Services...\e[0m\n"

docker-compose stop

docker-compose rm -f

echo -e "\n\e[32mStarting sc-server-config...\e[0m\n"

docker-compose up -d server-config

while [ -z ${ISC_CONFIG_READY} ]; do
  echo "Waiting for sc-server-config service..."
  if [ "$(curl --silent $DOCKER_IP:8100/health 2>&1 | grep -q '\"status\":\"UP\"'; echo $?)" = 0 ]; then
    ISC_CONFIG_READY=true;
  fi
  sleep 2
done

echo -e "\n\e[32mStarting sc-server-discovery...\e[0m\n"
# Start the discovery service next and wait
docker-compose up -d server-discovery

while [ -z ${ISC_DISCOVERY_READY} ]; do
  echo "Waiting for sc-server-discovery service..."
  if [ "$(curl --silent $DOCKER_IP:8200/health 2>&1 | grep -q '\"status\":\"UP\"'; echo $?)" = 0 ]; then
    ISC_DISCOVERY_READY=true;
  fi
  sleep 2
done

echo -e "\n\e[32mStarting sc-rabbitmq...\e[0m\n"
docker-compose up -d sc-rabbitmq

echo -e "\n\e[32mStarting sc-monitoring...\e[0m\n"
docker-compose up -d sc-monitoring

echo -e "\n\e[32mStarting sc-account...\e[0m\n"
docker-compose up -d sc-account

echo -e "\n\e[32mStarting sc-web...\e[0m\n"
docker-compose up -d sc-web

echo -e "\n\e[32mServer Config and Server Discovery started.\e[0m\n"