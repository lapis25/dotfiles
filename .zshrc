#keybinding
bindkey -e

#completion
autoload -Uz compinit
compinit
setopt complete_aliases
setopt list_packed
setopt nolistbeep
bindkey "\e[Z" reverse-menu-complete

#history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#correct
setopt correct

#cd
setopt auto_cd
setopt auto_pushd

#alias
alias ll='ls -l'

case $OSTYPE in
  darwin*)
    alias ls='ls -G -w'
    ;;
  linux*)
    alias ls='ls --color'
    ;;
esac

#ls/comp colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34' 'tw=42;30' 'ow=43;30'

#prompt
autoload colors
colors

PROMPT="%{${fg[cyan]}%}%n@%m%{${reset_color}%}:%{${fg[blue]}%}%(5~,%-3~/.../%2~,%~)%{${reset_color}%}%# "
PROMPT2="%{${fg[cyan]}%}%n@%m%{${reset_color}%}:%{${fg[blue]}%}%(5~,%-3~/.../%2~,%~)%{${reset_color}%}%# "
SPROMPT="%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "

#screen title set
preexec () {
  if [ ${TERM} = 'screen' ]; then
    echo -ne "\ek${1%% *}\e\\"
  fi
}

#other setting
setopt noautoremoveslash

