#!/bin/sh

echo isleme baslama zamani:
date +"%H:%M:%S"
sleep 1

# Bu skript ile, Ubuntu işletim sistemine yeni Kubernetes kurulumunu sıfırlayabilirsiniz :)
echo
echo -------------------------------------------------------------------------------------
echo "Merhaba, Kubernetes kurulumunu sıfırlayacak olan Droid'inim."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo kubeadm reset &&
sleep 2
sudo rm -rf /etc/kubernetes &&
sleep 2
sudo rm -rf /etc/cni/net.d &&
sleep 2
sudo rm -rf /var/lib/kubelet &&
sleep 2
sudo rm -rf /var/lib/etcd &&
sleep 2
sudo rm -rf $HOME/.kube

echo islemi tamamlama zamani:
date +"%H:%M:%S"
