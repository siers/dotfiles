# https://gist.githubusercontent.com/skanev/1716179/raw/47a340dbffcca469210cb4902c4406048c33b8fd/autocomplete_from_tmux.sh
# https://gist.github.com/skanev/1716179 : @skanevskanev/autocomplete_from_tmux.sh
# zsh: autocomplete words in current tmux session

# Autocomplete from current tmux screen buffer
_tmux_pane_words() {
  local expl
  local -a w

  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi

  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
