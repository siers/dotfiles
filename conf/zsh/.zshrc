stty stop ""

if [[ "$(uname)" == "Darwin" ]]; then ZSH_DARWIN=1; fi

alias zr='exec zsh'

. ~/.config/zsh/ps1
. ~/.config/zsh/env
. ~/.config/zsh/alias
. ~/.config/zsh/settings

. ~/.config/zsh/lib/autocomp-from-tmux.zsh
. ~/.config/zsh/sessions
. ~/.config/zsh/functions

[ -e ~/work/conf/scripts/profile ] && . ~/work/conf/scripts/profile

# http://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
