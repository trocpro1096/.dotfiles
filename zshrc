
# Lines configured by zsh-newuser-install
export HISTFILE=~/.histfile
export ZSH_PLUGIN=$HOME/.dotfiles/zsh-plugins
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -f -g ""'

HISTSIZE=40000
SAVEHIST=40000

####################
###    ALIAS     ###
####################

alias c=clear
alias l=lsd
alias ll='lsd -la --group-directories-first'
alias v=nvim
alias vf='nvim $(fzf)'
alias ...=../..

setopt autocd
setopt HIST_IGNORE_ALL_DUPS
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/datpc/.zshrc'

autoload -Uz compinit; compinit
# End of lines added by compinstall

# Make sure fzf-tab is sourced after autoload compinit and before another zsh plugins.
source "$ZSH_PLUGIN/fzf-tab/fzf-tab.plugin.zsh"

# Add syntax highlighting, autosuggestion feature like fish
source "$ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGIN/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGIN/zsh-z/zsh-z.plugin.zsh"
source "$ZSH_PLUGIN/zsh-fzf-history-search/zsh-fzf-history-search.zsh"

# Start starship prompt
eval "$(starship init zsh)"
# eval "$(atuin init zsh --disable-ctrl-r)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/datpc/miniforge-pypy3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ 1 -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/datpc/miniforge-pypy3/etc/profile.d/conda.sh" ]; then
#         . "/home/datpc/miniforge-pypy3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/datpc/miniforge-pypy3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# >>> Lazy-load conda >>>
# Add any commands which depend on conda here
lazy_conda_aliases=('python' 'conda')

load_conda() {
  for lazy_conda_alias in $lazy_conda_aliases
  do
    unalias $lazy_conda_alias
  done

  __conda_prefix="$HOME/miniforge-pypy3" # Set your conda Location

  # >>> conda initialize >>>
  __conda_setup="$("$__conda_prefix/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"

  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$__conda_prefix/etc/profile.d/conda.sh" ]; then
          . "$__conda_prefix/etc/profile.d/conda.sh"
      else
          export PATH="$__conda_prefix/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  unset __conda_prefix
  unfunction load_conda
}

for lazy_conda_alias in $lazy_conda_aliases
do
  alias $lazy_conda_alias="load_conda && $lazy_conda_alias"
done
# <<< Lazy load conda <<<
