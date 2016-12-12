# Spring Cloud Project - sc-ci

Docker compose with build and startup scripts.

Landing page for repositories associated with Spring Cloud Project Sample

# Related repositories
- https://github.com/mszpiler/sc-config-repo - configuration repository
- https://github.com/mszpiler/sc-server-discovery - Server Discovery repository
- https://github.com/mszpiler/sc-server-config - Server Config repository
- https://github.com/mszpiler/sc-monitoring - Monitoring Service repository
- https://github.com/mszpiler/sc-account - Account Service repository
- https://github.com/mszpiler/sc-web - Web Service repository


## Usefull commands

- docker rmi $(docker images -q)  - remove all images
- docker volume rm $(docker volume ls -f dangling=true -q) - remove all volumes