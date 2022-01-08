# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.poetry/bin:$PATH"
#. "$HOME/.cargo/env"

export PATH="$PATH:/usr/local/go/bin"
export EDITOR=`which nvim`
export VISUAL=`which nvim`
export PATH="$PATH:$(go env GOPATH)/bin"
