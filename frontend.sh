#!/bin/sh
docker stop frontend
docker-compose -f docker-compose.yml -f docker-compose.dev.yml  up --build -d frontend
# open works for OSX. Linux systems have multiple versions to open a web page
open https://localhost