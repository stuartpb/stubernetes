kubeadm init --image-repository k8s.gcr.io
KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(KUBECONFIG=/etc/kubernetes/admin.conf kubectl version | base64 | tr -d '\n')"
