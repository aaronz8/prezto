
alias k=kubectl
alias kgp='kubectl get pods'
alias kgs='kubectl get service'
alias kpf='kubectl port-forward'

function kl() {
	if (( ${+1} )); then
		kubectl logs -n $1 -f --tail=200 $(kubectl get pods -n $1 --output=name | grep ${2}) ${@:3}
	else
		kubectl logs -f
	fi
}
function kdp() {
	if (( ${+1} )); then
		kubectl delete $(kubectl get pods --output=name | grep ${1})
	else
		echo "requires 1 arg"
	fi
}
