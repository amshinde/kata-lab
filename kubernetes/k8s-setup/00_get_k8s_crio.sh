export PATH="$PATH:/usr/local/go/bin"
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

go get -u github.com/kata-containers/tests
pushd $GOPATH/src/github.com/kata-containers/tests
./.ci/install_kubernetes.sh
sudo -E apt install -y libglib2.0-dev libseccomp-dev libapparmor-dev \
        libgpgme11-dev go-md2man thin-provisioning-tools
.ci/install_crio.sh
.ci/install_cni_plugins.sh

crio_config_file=/etc/crio/crio.conf

# Set the default trust level as trusted for crio
sudo sed -i 's/default_workload_trust = .*$/default_workload_trust = "trusted"/' "$crio_config_file"

# Set Kata as the deafult runtime for untrusted workloads
sudo sed -i 's/runtime_untrusted_workload = .*$/runtime_untrusted_workload = "\/usr\/bin\/kata-runtime"/' "$crio_config_file"
sudo systemctl daemon-reload

# Turn swap off and mask swap targets
#sudo swapoff -a
#sudo -E systemctl mask swap.target

#./integration/kubernetes/init.sh

#rm -rf $HOME/.kube
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

popd
