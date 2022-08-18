#!/usr/bin/env bash

bash ./build-natives.sh
cd java || exit
mvn install
cd ..