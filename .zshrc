# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh/custom

# Set name of the theme to load.
ZSH_THEME="robbyrussell"
#ZSH_THEME="random"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx brew cpanm plenv screen)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# history
HISTSIZE=1000000
SAVEHIST=1000000
function history-all { history -E 1 }

# alias
alias l=less
alias s="screen -R"
alias e='emacsclient'
