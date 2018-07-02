sudo rm -rf $HOME/.kube
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

master=$(hostname)
kubectl taint nodes "$master" node-role.kubernetes.io/master:NoSchedule-
