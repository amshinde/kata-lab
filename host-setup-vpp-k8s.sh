set -e 
SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

$SCRIPT_PATH/vpp/vpp-host-setup/00_get-vpp.sh 
$SCRIPT_PATH/vpp/vpp-host-setup/01_get-docker.sh 
$SCRIPT_PATH/vpp/vpp-host-setup/02_get-kata-containers.sh 
$SCRIPT_PATH/vpp/vpp-host-setup/03_get-vpp-plugin.sh 
$SCRIPT_PATH/kubernetes/k8s-setup/00_get_k8s_crio.sh
