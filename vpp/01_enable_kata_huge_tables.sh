sudo sed -i -e 's/^# *\(enable_hugepages\).*=.*$/\1 = true/g' /usr/share/defaults/kata-containers/configuration.toml
sudo sed -i -e 's/\(enable_hugepages\).*=.*$/\1 = true/g' /usr/share/defaults/kata-containers/configuration.toml
