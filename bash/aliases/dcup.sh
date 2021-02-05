#!/bin/bash

if [[ -z $* ]]
then
	docker-compose up
elif [[ $1 == '--build' ]]
then
	docker-compose up --build
else
	docker-compose -f docker-compose-$1.yml up $2
fi
