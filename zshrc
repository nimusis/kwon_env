# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export XDG_CONFIG_HOME=$HOME/.kwon_env
export FZF_BASE=$XDG_CONFIG_HOME/fzf
export ZSH=$XDG_CONFIG_HOME/oh-my-zsh
export PATH=$PATH:$XDG_CONFIG_HOME/bin
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting tmux tmuxinator fzf)
source $ZSH/oh-my-zsh.sh
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi  
}
export TERM=xterm-256color
export SHELL=/usr/bin/zsh


############################### FZF
export FZF_DEFAULT_OPTS='
  --color=bg+:5,fg+:255,info:6,pointer:255,prompt:5,marker:3
  --height 70%
  --reverse
  --border
  --prompt="---● "
  --bind "ctrl-/:toggle-preview"
  --bind "PgUp:preview-page-up"
  --bind "PgDn:preview-page-down"
  --bind "ctrl-e:execute(vim -u $XDG_CONFIG_HOME/vimrc {} >/dev/tty </dev/tty)"
'
export FZF_PREVIEW_COMMAND='
  ( [[ $(file --mime {}) =~ binary ]] && ! [[ $(file --mime {}) =~ directory ]] ) &&
  echo {} is a binary file ||
  (bat --theme="OneHalfDark" --style=numbers,changes --wrap never --color=always {} ||
  cat {} ||
  tree -C {})
'
export FZF_CTRL_T_OPTS="--preview-window right:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"


function fif() {
  if [ ! "$#" -gt 0 ]; then echo "검색어를 입력해주세요."; return 1; fi
  if [ -z "$(command -v rg)" ]; then echo "rg(ripgrep) 이 설치되어 있지 않습니다."; return 1; fi
  rg --files-with-matches --no-messages $2 "$1" | fzf\
  --height 80%\
  --extended\
  --ansi\
  --cycle\
  --header 'Find in File'\
  --preview "(bat --theme='OneHalfDark' --style=numbers,changes --wrap never --color=always {} || cat {}) | rg --colors 'match:bg:yellow' --ignore-case --pretty --no-line-number --context 10 '$1' || rg --ignore-case --pretty --no-line-number --context 10 '$1' {}"
}

function sdt() {
  if [ -z "$(command -v tree)" ]; then echo "tree가 설치되어 있지 않습니다."; return 1; fi
  local dir
  dir=$(find . -type d -not -path '*/\.git/*' 2>/dev/null | fzf\
  --header 'Search In Directory'\
  --height 80%\
  --extended\
  --ansi\
  --cycle\
  --header 'Search Directory'\
  --preview 'tree -d -C -L 2  {} | head -200 2>/dev/null'\
  --preview-window=right:50%) && cd "$dir"
}

###############################
alias vi='vim -u $XDG_CONFIG_HOME/vimrc'
alias vim='vim -u $XDG_CONFIG_HOME/vimrc'
alias mux="tmuxinator"

tmux source $XDG_CONFIG_HOME/tmux/tmux.conf
