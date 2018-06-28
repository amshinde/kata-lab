set -e

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

# The next workaround is to be able to communicate between pods
# Issue: https://github.com/kubernetes/kubernetes/issues/40182
# Fix is ready for K8s 1.9, but still need to investigate why it does not
# work by default.
# FIXME: Issue: https://github.com/clearcontainers/tests/issues/934
sudo iptables -P FORWARD ACCEPT

echo "Start crio service"
sudo systemctl start crio

sudo rm -rf $HOME/.kube

sudo -E kubeadm init --pod-network-cidr 10.244.0.0/16 --cri-socket=/var/run/crio/crio.sock
export KUBECONFIG=/etc/kubernetes/admin.conf

sudo -E kubectl get nodes
sudo -E kubectl get pods
sudo -E kubectl create -f "${SCRIPT_PATH}/data/kube-flannel-rbac.yml"
sudo -E kubectl create --namespace kube-system -f "${SCRIPT_PATH}/data/kube-flannel.yml"

# The kube-dns pod usually takes around 30 seconds to get ready
# This instruction will wait until it is up and running, so we can
# start creating our containers.
dns_wait_time=180
sleep_time=5
cmd="sudo -E kubectl get pods --all-namespaces | grep dns | grep Running"
waitForProcess "$dns_wait_time" "$sleep_time" "$cmd"
