kubectl get pods | sed '1d' | cut -d" " -f1 | xargs kubectl delete pod $1
