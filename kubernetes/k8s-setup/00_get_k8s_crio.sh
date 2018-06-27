export PATH="$PATH:/usr/local/go/bin"
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

go get -u github.com/kata-containers/tests
pushd $GOPATH/src/github.com/kata-containers/tests
ls
.ci/install_kubernetes.sh
sudo -E apt install -y libglib2.0-dev libseccomp-dev libapparmor-dev \
        libgpgme11-dev go-md2man thin-provisioning-tools
.ci/install_crio.sh
./integration/kubernetes/init.sh
popd
