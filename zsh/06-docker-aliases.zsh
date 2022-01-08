alias dkill='docker kill $(docker ps -q)'
alias dstop='docker stop $(docker ps -q)'
alias dps='docker ps'

_dc_cmd="docker-compose"

_get_arg() {
	target=$1
	shift
	args=("$@")

	_result=""
	_found=0
	for arg in $args
	do
		if [ $_found = 1 ]; then
			_result=$arg
			break	
		elif [ $arg = $target ]; then
			_found=1
		fi
	done

	echo $_result
}

_is_set() {
	target=$1
	shift
	args=("$@")

	_found=0
	for arg in $args
	do
		if [ $arg = $target ]; then
			_found=1
			break
		fi
	done
	echo $_found
}


_get_docker_command_with_file() {
	cmd="$_dc_cmd"

	if [[ ! -z $* ]]; then

		file=$(_get_arg "-f" $*)
		if [[ ! -z $file ]]; then
			cmd="$cmd -f docker-compose-$file.yml"
		fi
	fi

	echo $cmd
}

_remove_param() {
	target=$1
	shift
	args=$(echo "$@" | xargs)

	echo $args | sed "s/$target//" | xargs
}

dcup() {
	cmd=$(_get_docker_command_with_file $*)
	if [[ -z $* ]]
	then
		cmd="$cmd up"
	else
		build=$(_is_set "--build" $*)
		services=$(_get_arg "-s" $*)
		cmd="$cmd up"

		if [[ ! -z $services ]]; then
			cmd="$cmd $services"
		fi

		if [[ ! $build = 0 ]]; then
			cmd="$cmd --build"
		fi
	fi

	echo $cmd
	eval $cmd
}

dcexec() {
	cmd="$(_get_docker_command_with_file $*) exec"
	if [[ $# -lt 2 ]]
	then
		echo "dcexec expects at least two arguments: [<option>, ...] <service> <command> [<params>, ...]" 	
	else
		user=$(_get_arg "-u" "$@")
		privileged=$(_is_set "-p" "$@")
		index=$(_get_arg "-i" "$@")
		file=$(_get_arg "-f" "$@")

		args="$@"
		if [[ ! -z $user ]]; then
			cmd="$cmd -u $user"
			args=$(_remove_param "-u $user" $args)
		fi

		if [[ $privileged -ne 0 ]]; then
			cmd="$cmd --privileged"
			args=$(_remove_param "-p" $args)
		fi

		if [[ ! -z $index ]]; then
			cmd="$cmd --index=$index"
			args=$(_remove_param "-i $index" $args)
		fi
		if [[ ! -z $file ]]; then
			args=$(_remove_param "-f $file" $args)
		fi

		cmd="$cmd $args"

	fi

	echo $cmd
	eval $cmd
}

dcbuild() {
	cmd=$(_get_docker_command_with_file $*)
	if [[ -z $* ]]
	then
		cmd="$cmd build"
	else
		no_cache=$(_is_set "--no-cache" $*)
		services=$(_get_arg "-s" $*)
		cmd="$cmd build"

		if [[ ! -z $services ]]; then
			cmd="$cmd $services"
		fi

		if [[ ! $no_cache = 0 ]]; then
			cmd="$cmd --no-cache"
		fi
	fi

	echo $cmd
	eval $cmd
}

drm() {
	if [[ -z $* ]]; then
		echo "drm expects at least one argument"
		exit 1
	fi

	for arg in "$@"; do
		cmd="docker rm $(docker ps -a | grep $arg | awk '{ print $1 }')"
		echo $cmd
		eval $cmd
	done
}
