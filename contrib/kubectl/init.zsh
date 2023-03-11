if (( ! $+commands[kubectl] )); then
  return
fi

# Placeholder 'kubectl' shell function:
# Will only be executed on the first call to 'kubectl'
kubectl() {
  # Remove this function, subsequent calls will execute 'kubectl' directly
  unfunction "$0"

  local COMPLETIONS_DIR="$ZPREZTODIR/contrib/kubectl/completions"

  # Only regenerate completions if does not exist or older than 24 hours
  if [[ ! -f "$COMPLETIONS_DIR/_kubectl" || ! $(find "$COMPLETIONS_DIR/_kubectl" -newermt "24 hours ago" -print) ]]; then
    echo "Generating kubectl completions.. in $COMPLETIONS_DIR"
    kubectl completion zsh 2> /dev/null >| "$COMPLETIONS_DIR/_kubectl" &|
    ls $COMPLETIONS_DIR
  fi

  # Add completions to the FPATH
  typeset -TUx FPATH fpath
  fpath=("$COMPLETIONS_DIR" $fpath)

  complete -F __start_kubectl k

  # Execute 'kubectl' binary
  $0 "$@"
}

# Source module files.
source "${0:h}/alias.zsh"
