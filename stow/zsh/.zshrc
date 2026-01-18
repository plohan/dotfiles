# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="linuxonly"

export PATH="$PATH:/Users/pannawich/.local/bin"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval "$(zoxide init zsh)"
export PATH="/Users/pannawich/.local/state/fnm_multishells/11544_1743774962254/bin":$PATH
export FNM_MULTISHELL_PATH="/Users/pannawich/.local/state/fnm_multishells/11544_1743774962254"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/Users/pannawich/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"
rehash

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pannawich/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pannawich/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pannawich/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pannawich/tools/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(direnv hook zsh)"


# pnpm
export PNPM_HOME="/Users/pannawich/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$PATH:/Users/pannawich/go/bin"

mkcd () {
  mkdir -p "$1"
  cd "$1"
}

cdtemp () {
  cd $(mktemp -d)
}

yp () {
  pwd | pbcopy
}

bundle() {
  b64="$(
    tar -cf - --no-xattrs "$@" \
    | gzip -9 \
    | base64 | tr -d '\n'
  )" || return 1

  printf "echo '%s' | base64 -d | gzip -d | tar -xf -\n" "$b64"
}

bundley() {
  b64="$(
    tar -cf - --no-xattrs "$@" \
    | gzip -9 \
    | base64 | tr -d '\n'
  )" || return 1

  printf "echo '%s' | base64 -d | gzip -d | tar -xf -\n" "$b64" | pbcopy
}

bundleremote() {
  echo 'echo YnVuZGxlKCkgewogIGI2ND0iJCh0YXIgLWNmIC0gLS1uby14YXR0cnMgIiRAIiB8IGd6aXAgLTkgfCBiYXNlNjQgLXcgMCkiIHx8IHJldHVybiAxCiAgcHJpbnRmICJlY2hvICclcycgfCBiYXNlNjQgLWQgfCBnemlwIC1kIHwgdGFyIC14ZiAtIiAiJGI2NCIKfQo= | base64 -d | eval'
}

eval "$(mise activate)"
export COREPACK_ENABLE_AUTO_PIN=0
alias k="kubectl"
alias lj="lazyjj"
alias book-sync="make -C ~/work/book"

[ -f "/Users/pannawich/.ghcup/env" ] && . "/Users/pannawich/.ghcup/env" # ghcup-env
