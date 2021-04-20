#!/bin/bash

if [[ $# -eq 1 ]]
then
	docker rm `docker ps -a | grep $1 | awk '{print $1;}'`
else
    echo "Command requires at least one parameter"
fi