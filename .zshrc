# -----------------------------
# Console-output commands first
# -----------------------------
# Start ssh-agent if not running (prints to console)
# if ! pgrep -u $USER ssh-agent > /dev/null; then
#     eval $(ssh-agent -s)
# fi
# if [ -x /usr/bin/gnome-keyring-daemon ]; then
#     eval $(/usr/bin/gnome-keyring-daemon --start --components=ssh)
#     export SSH_AUTH_SOCK
# fi


export PNPM_HOME="/home/zeshan6a/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# Load Homebrew (may print)
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# -----------------------------
# Powerlevel10k instant prompt
# -----------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------
# Powerlevel10k customization
# -----------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -----------------------------
# Zinit plugin manager
# -----------------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi 

source "$ZINIT_HOME/zinit.zsh"

# Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git 

# -----------------------------
# ENVIRONMENT & PATHS
# -----------------------------
export EDITOR='nvim'
export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"

# -----------------------------
# Key bindings
# -----------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# -----------------------------
# History settings
# -----------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=0
setopt APPEND_HISTORY EXTENDED_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS

# -----------------------------
# Completions
# -----------------------------
autoload -Uz compinit && compinit
autoload -U colors && colors
zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle 'fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -----------------------------
# Aliases
# -----------------------------
alias nv='nvim'
alias cl='clear'
alias ff='fastfetch'

# eza (modern ls replacements)
alias ls='eza --color=always --icons=always'
alias ll='eza -lh --color=always --icons=always --git'
alias la='eza -lha --color=always --icons=always --git'
alias tree='eza --tree --icons=always'

# -----------------------------
# External tools
# -----------------------------
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# opencode
export PATH=/home/zeeshan506/.opencode/bin:$PATH    
