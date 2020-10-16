kubeadm init --image-repository k8s.gcr.io --pod-network-cidr=10.244.0.0/16
KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
