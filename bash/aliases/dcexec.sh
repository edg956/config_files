#!/bin/bash
args=($*)

if [[ -z ${args[@]:2} ]]
then
	echo "dcexec requires at least 3 arguments"
	exit -1
fi

compose_argument=''

compose_file=${args[0]}
if [[ $compose_file != '--' ]]
then
	compose_argument="-f docker-compose-$compose_file.yml "
fi

docker-compose ${compose_argument}exec ${args[@]:1}
