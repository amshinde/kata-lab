sudo apt-get install wget

GO_VER=1.10.1
cd /tmp && wget https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz

echo 'export PATH="$PATH:/usr/local/go/bin"' | sudo tee -a /etc/profile
echo 'export GOPATH="$HOME/go"' | sudo tee -a /etc/profile 
echo 'export PATH="$PATH:$GOPATH/bin"' | sudo tee -a /etc/profile
source /etc/profile

#sudo apt-get install golang-go

#export GOPATH=/home/"$USER"/goworkspace
export GOPATH=$HOME/go

mkdir -p $GOPATH
go get github.com/clearcontainers/vpp

sudo mkdir -p /etc/docker/plugins

sudo cp $GOPATH/src/github.com/clearcontainers/vpp/vpp.json /etc/docker/plugins

sudo $GOPATH/bin/vpp &

sudo systemctl daemon-reload
sudo systemctl restart docker
