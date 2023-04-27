#!/bin/bash

echo 安装 k8s 套件
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
echo 'deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list
sudo apt update && apt install -y kubelet=1.23.1-00 kubeadm=1.23.1-00 kubectl=1.23.1-00
rm /etc/containerd/config.toml
systemctl restart containerd
kubeadm init --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'

echo "写入 k8s alias"
echo "alias kcl='kubectl'" >> ~/.zshrc
echo "alias kd='kubectl describe'" >> ~/.zshrc
echo "alias klt='kubelet'" >> ~/.zshrc


echo 修改 iptables 配置
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward=1 # better than modify /etc/sysctl.conf
EOF

sudo sysctl --system

echo 关闭 Linux 的 swap 分区，提升 Kubernetes 的性能
sudo swapoff -a
sudo sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

echo 安装 kubeadm
sudo apt-get install -y gnupg2
sudo apt-get install -y apt-transport-https ca-certificates
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
sudo apt update

sudo apt install -y kubeadm=1.23.3-00 kubelet=1.23.3-00 kubectl=1.23.3-00

echo 修改 etcd apiserer 等镜像地址
repo=registry.aliyuncs.com/google_containers

for name in `kubeadm config images list --kubernetes-version v1.23.3`; do

    src_name=${name#k8s.gcr.io/}
    src_name=${src_name#coredns/}

    docker pull $repo/$src_name

    docker tag $repo/$src_name $name
    docker rmi $repo/$src_name
done

