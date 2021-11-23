# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

for i in `pstree -np -s $$ | grep -o -E '[0-9]+'`; do
	if [[ -e "/run/WSL/${i}_interop" ]];
	then
		export WSL_INTEROP=/run/WSL/${i}_interop
	fi
done

export PATH="$HOME/.poetry/bin:$PATH"
. "$HOME/.cargo/env"

export PATH="$PATH:/usr/local/go/bin"
export EDITOR="/bin/nvim"
