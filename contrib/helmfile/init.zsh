if (( ! $+commands[helmfile] )); then
  return
fi

# Placeholder 'helmfile' shell function:
# Will only be executed on the first call to 'helmfile'
helmfile() {
  # Remove this function, subsequent calls will execute 'helmfile' directly
  unfunction "$0"

  local COMPLETIONS_DIR="$ZPREZTODIR/contrib/helmfile/completions"

  # Only regenerate completions if does not exist or older than 24 hours
  if [[ ! -f "$COMPLETIONS_DIR/_helmfile" || ! $(find "$COMPLETIONS_DIR/_helmfile" -newermt "24 hours ago" -print) ]]; then
    curl https://raw.githubusercontent.com/roboll/helmfile/master/autocomplete/helmfile_zsh_autocomplete 2> /dev/null >| "$COMPLETIONS_DIR/_helmfile" &|
  fi

  # Add completions to the FPATH
  typeset -TUx FPATH fpath
  fpath=("$COMPLETIONS_DIR" $fpath)

  # Execute 'helmfile' binary
  $0 "$@"
}
