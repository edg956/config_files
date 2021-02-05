#!/bin/bash

if [[ -z $* ]]
then
	docker-compose build
elif [[ $1 == '--no-cache' ]]
then
	docker-compose build --no-cache
else
	docker-compose -f docker-compose-$1.yml build $2
fi
