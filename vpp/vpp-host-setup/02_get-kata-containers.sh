set -e

## Install Kata Containers packages:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/katacontainers:/alpha/xUbuntu_$(lsb_release -rs)/ /' > /etc/apt/sources.list.d/kata-containers.list"
curl -sL  http://download.opensuse.org/repositories/home:/katacontainers:/alpha/xUbuntu_$(lsb_release -rs)/Release.key | sudo apt-key add -
sudo -E apt-get update
sudo -E apt-get -y install kata-runtime kata-proxy kata-shim

## Configure Docker to use Kata Containers by default
sudo mkdir -p /etc/systemd/system/docker.service.d/
cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/kata-containers.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -D --add-runtime kata-runtime=/usr/bin/kata-runtime --default-runtime=kata-runtime
EOF

## Restart Docker to take change into account:
sudo systemctl daemon-reload
sudo systemctl restart docker
