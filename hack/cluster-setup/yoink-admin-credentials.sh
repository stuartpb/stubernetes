# Gets the lines I need to reroll my kubeconfig
# usage: bash yoink-admin-credentials.sh mpi-rose
ssh "root@$1" grep 'data:' /etc/kubernetes/admin.conf
