export LANG=ja_JP.UTF-8
autoload -U compinit
compinit
bindkey -e 

setopt autopushd 
setopt listpacked
setopt nolistbeep 

# color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#alias ls="ls -G"
#alias ls="ls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'


case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
#    PROMPT="%{[31m%}${USER}@%/%%%{[m%} "
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac 

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 


case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac

# for Git
export GIT_SSL_NO_VERIFY=true

export CFLAGS="-march=core2 -O2 -fomit-frame-pointer"
export CXXFLAGS="-march=core2 -O2 -fomit-frame-pointer"

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
alias mysql="/usr/local/mysql/bin/mysql"

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/sbin:/opt/local/bin:/usr/local/mysql/bin:/Users/kaz/.gem/ruby/1.8/bin:$PATH"

