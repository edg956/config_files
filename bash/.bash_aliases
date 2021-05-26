# alias for docker-compose things
alias dcup='dcup.sh'
alias dcbuild='dcbuild.sh'
alias dcexec='dcexec.sh'
alias dkill='docker kill $(docker ps -q)'
alias dstop='docker stop $(docker ps -q)'
alias dps='docker ps'
alias drm='drm.sh'

random_string() {
	num=${1:-12}

	if [ $num -lt 0 ];
	then
		num=0
	fi

	regex=${2:-'A-Za-z0-9'}

	tr -dc $regex < /dev/urandom | head -c $num
	echo ''
}

git_ssh() {
	ssh_path=$HOME/.ssh
	
	if [ -z $SSH_AGENT_PID ]; then
		eval `ssh-agent` 
	else
		echo "Using ssh-agent with PID $SSH_AGENT_PID"
	fi

	for i in $*; do
		if [ ! -f $ssh_path/$i ]; then
			echo "File $ssh_path/$i does not exist"
		else
			echo "Adding $i"
			ssh-add $ssh_path/$i
		fi
	done
}
