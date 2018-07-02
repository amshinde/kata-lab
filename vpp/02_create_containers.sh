sudo vppctl show int

while [ $? -ne 0 ]; do 
sudo vppctl show int; 
done
# Create docker containers, testing their connectivity over L2-bridge:
sudo docker run --runtime=kata-runtime --net=vpp_net --ip=192.168.1.2 --mac-address=CA:FE:CA:FE:01:02 --name "hasvpp1" -itd egernst/network-testing-ubuntu bash
sudo docker run --runtime=kata-runtime --net=vpp_net --ip=192.168.1.3 --mac-address=CA:FE:CA:FE:01:03 --name "hasvpp2" -itd egernst/network-testing-ubuntu bash
