kubeadm init --image-repository k8s.gcr.io --pod-network-cidr=10.244.0.0/16
KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
