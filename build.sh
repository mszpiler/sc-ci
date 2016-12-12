#!/usr/bin/env bash

set -e

cd "../sc-server-config"
mvn clean install

cd "../sc-server-discovery"
mvn clean install

cd "../sc-monitoring"
mvn clean install

cd "../sc-account"
mvn clean install

cd "../sc-web"
mvn clean install