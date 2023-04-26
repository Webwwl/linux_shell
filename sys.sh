#!/bin/bash
echo 修改 hosts 文件
echo "185.199.110.133  raw.github.com
140.82.113.4  github.com" >> /etc/hosts

echo 修改 apt 镜像源
echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
deb http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib" > /etc/apt/sources.list

sudo apt-get udpate