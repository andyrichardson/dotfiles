# Brew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Gnu utils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix grep)/libexec/gnubin:$PATH"

# Env
export NVM_AUTO_USE=true


## Plugins
source ~/.zsh/antigen.zsh
antigen use oh-my-zsh

antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-completions
antigen bundle npm
antigen bundle chrissicool/zsh-256color
antigen bundle gitfast
antigen bundle amstrad/oh-my-matrix
antigen bundle lukechilds/zsh-nvm
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle andyrichardson/zsh-node-path
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen bundle nocttuam/autodotenv
antigen bundle autojump
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme agnoster

antigen apply

alias lc="colorls"
