export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=/usr/local/man:$MANPATH
export LANG=en_US.UTF-8

export DISPLAY=:0
export EDITOR=vim
export PAGER=less

# http://www.gcd.org/blog/2006/09/100/
agent="$HOME/tmp/ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
        case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
                ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
        esac
elif [ -S $agent ]; then
        export SSH_AUTH_SOCK=$agent
else
        echo "no ssh-agent"
fi
