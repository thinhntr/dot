# -------------------------------------------
# | ENVIRONMENT VARIABLES                   |
# -------------------------------------------
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/utils:$HOME/bin:$PATH"

WORDCHARS="*?_.[]~=&;!#$%^(){}<>"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# -------------------------------------------
# | ZSH CUSTOMIZATIONS                      |
# -------------------------------------------
bindkey -e
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
zstyle ':completion:*' menu select
# Allow to select in a menu
zstyle ':completion:*' menu select
# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# -------------------------------------------
# | ALIASES AND FUNCTIONS                   |
# -------------------------------------------
alias v="nvim"
alias t='tmux'
alias ap='ansible-playbook'
alias ls='ls --color=auto'
alias grep='grep --color=auto'


alias g='git'
alias glo='git log --oneline'
alias gloga='git log --oneline --graph --all'

alias note='v ~/note'
alias diff='diff --color=auto -u'

alias pgg='curl https://api.ipify.org'

# -------------------------------------------
# | LOAD PLUGINS                            |
# -------------------------------------------
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh --shims)"
for plugin in $(find ~/zsh-custom); do
    [[ "${plugin##*.}" == "zsh" ]] && source $plugin
done

# vim: set nowrap et ts=4 sts=0 sw=0:
