# -------------------------------------------
# | ENVIRONMENT VARIABLES                   |
# -------------------------------------------
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.bun/bin:$HOME/.local/share/bob/nvim-bin:$HOME/utils:$HOME/bin:$PATH"

WORDCHARS="*?_.[]~=&;!#$%^(){}<>"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# -------------------------------------------
# | ZSH CUSTOMIZATIONS                      |
# -------------------------------------------
bindkey -e # use emacs keymaps

bindkey "^[[3~" delete-char # hack: fix tmux removes delete-char keybind

# auto completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
_comp_options+=(globdots) # With hidden files
# Allow to select in a menu
zstyle ':completion:*' menu select
# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# edit command in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# -------------------------------------------
# | ALIASES AND FUNCTIONS                   |
# -------------------------------------------
alias v="nvim"
alias t='tmux'
alias k='kubectl'
alias ap='ansible-playbook'
alias dk='docker'
alias tf='terraform'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias z='cd `tt | fzf`'
alias reload='source ~/.zshrc'


alias g='git'
alias glo='git log --oneline'
alias gloga='git log --oneline --graph --all'

alias note='v ~/note'
alias diff='diff --color=auto -u'

alias pgg='curl https://api.ipify.org'

alias rma='tee >(xargs rm -fr)'

dkrm() {
    docker ps -aq | tee >(xargs docker kill) >(xargs docker rm)
    docker images -q --filter 'dangling=true' | tee >(xargs docker rmi -f)
}

dkrma() {
    dkrm
    docker builder prune --all -f
}

gfp() {
    git pull --prune
    git branch -vv | rg ': gone]' | awk '{print $1}' | xargs git branch -D
}
# -------------------------------------------
# | LOAD PLUGINS                            |
# -------------------------------------------
[[ -f /usr/bin/mise ]] && eval "$(/usr/bin/mise activate zsh)"
for plugin in $(find ~/zsh-custom); do
    [[ "${plugin##*.}" == "zsh" ]] && source $plugin
done

# vim: set nowrap et ts=4 sts=0 sw=0:
