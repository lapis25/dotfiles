#keybinding
bindkey -e

stty stop undef

#hook
autoload -Uz add-zsh-hook

#completion
fpath=($HOME/.zsh/functions $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1

#setopt completealiases
setopt list_packed
setopt nolistbeep
bindkey "\e[Z" reverse-menu-complete

#history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
function history-all { history -E 1 }

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
    alias ls='ls --color=alway'
    ;;
esac

alias l='less'
alias s="screen -R"
alias e='emacsclient'

#ls/comp colors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;36' 'tw=42;30' 'ow=43;30'

#prompt
setopt prompt_subst
autoload colors
colors

if [ -e "$HOME/bin/git-completion" ] ; then
  source $HOME/bin/git-completion
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  export RPROMPT='$(__git_ps1)'
  # U  update
  # S  stashed
  #"✚" staged
  #"-" unstaged $GIT_PS1_SHOWDIRTYSTATE
  #"✘" untracked $GIT_PS1_SHOWUNTRACKEDFILES
fi

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git svn
# zstyle ':vcs_info:svn:*' branchformat '%b:r%r'

# function _precmd_vcs_info () {
#   LANG=en_US.UTF-8 vcs_info
# }
# add-zsh-hook precmd _precmd_vcs_info
# zstyle ':vcs_info:bzr:*' use-simple true
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:*' formats "%{${fg[gray]}%}%s ➜ %{${reset_color}%}%{${fg_bold[gray]}%}%b%{${reset_color}%} %c%u"
# zstyle ':vcs_info:*' actionformats "%{${fg[grey]}%}%s ➜ %{${reset_color}%}%{${fg_bold[grey]}%}%b%{${reset_color}%}%{${fg_bold[red]}%}[$a]%{${reset_color}%} %c%u"
# zstyle ':vcs_info:git:*' stagedstr "✚"
# zstyle ':vcs_info:git:*' unstagedstr "✘"

PROMPT="%{${fg[cyan]}%}%n@%m%{${reset_color}%}:%{${fg[red]}%}%(5~,%-3~/.../%2~,%~)%{${reset_color}%}%# "
PROMPT2="%{${fg[cyan]}%}%n@%m%{${reset_color}%}:%{${fg[red]}%}%(5~,%-3~/.../%2~,%~)%{${reset_color}%}%# "
SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#export RPROMPT='${vcs_info_msg_0_}'

#less
export LESS="-R"

#screen title set
preexec () {
  if [ ${TERM} = 'screen' -o ${TERM} = 'screen-256color' -o ${TERM} = 'screen-256color-bce' ]; then
    echo -ne "\ek${1%% *}\e\\"
  fi
}

#other setting
setopt noautoremoveslash

#reload comp funcs
r() {
  local f
  f=(~/.zsh/functions/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}

source $HOME/perl5/perlbrew/etc/bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#if [ -f ~/bin/git-completion ]; then
#  . ~/bin/git-completion
#fi

