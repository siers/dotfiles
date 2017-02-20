stty stop ""

. ~/.config/zsh/ps1
. ~/.config/zsh/env
. ~/.config/zsh/alias
. ~/.config/zsh/settings

. ~/.config/zsh/sessions
. ~/.config/zsh/functions

# http://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
