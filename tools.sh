#!/bin/bash
echo 安装zsh
apt-get install -y zsh

echo 安装git
sudo apt-get install -y git

echo  安装 nslookup 工具
sudo apt-get install -y dnsutils

echo 安装curl
sudo apt-get install -y curl

echo 切换默认 shell 到 zsh
chsh -s /bin/zsh

echo 安装 oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 安装 oh-my-zsh 插件

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo 插件 zsh-autosuggestions clone 完成

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo 插件 zsh-syntax-highlighting clone 完成

cp ~/.zshrc ~/.zshrc_bak
# sed -i ~/.zshrc 'plugins=/d'
echo "plugins=(git zsh-syntax-highlighting z zsh-autosuggestions)" >> ~/.zshrc
echo oh-my-zsh 插件安装完毕

source ~/.zshrc