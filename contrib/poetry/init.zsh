export PATH=$PATH:$HOME/.local/bin

if (( ! $+commands[poetry] )); then
  return
fi

# Placeholder 'poetry' shell function:
# Will only be executed on the first call to 'poetry'
poetry() {
  # Remove this function, subsequent calls will execute 'poetry' directly
  unfunction "$0"

  local COMPLETIONS_DIR="$ZPREZTODIR/contrib/poetry/completions"

  # Only regenerate completions if does not exist or older than 24 hours
  if [[ ! -f "$COMPLETIONS_DIR/_poetry" || ! $(find "$COMPLETIONS_DIR/_poetry" -newermt "24 hours ago" -print) ]]; then
    poetry completions zsh > "$COMPLETIONS_DIR/_poetry"
  fi

  # Add completions to the FPATH
  typeset -TUx FPATH fpath
  fpath=("$COMPLETIONS_DIR" $fpath)

  # Execute 'poetry' binary
  $0 "$@"
}
