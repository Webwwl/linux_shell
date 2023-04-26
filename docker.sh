#!/bin/bash

echo  安装 docker
sudo apt-get install -y docker.io
sudo service docker start

echo docker 镜像源配置
echo '{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://t9ab0rkd.mirror.aliyuncs.com"]
}' > /etc/docker/daemon.

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "写入 docker alias"
echo "alias d='docker'" >> ~/.zshrc
echo "alias dm='docker image'" >> ~/.zshrc
echo "alias dc='docker container'" >> ~/.zshrc