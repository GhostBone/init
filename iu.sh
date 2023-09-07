#!/bin/bash
set -Eeuo pipefail

echo "----------/ Powered by Ghost_bone /----------";
echo "This script is used to initialize the Ubuntu ";
echo "server system personalized, and is applicable ";
echo "to Ubuntu server 20 and above. (e.g., 22.04LTS) ";
echo "Detailed reference: https://github.com/GhostBone/init-ubuntu";
echo "----------/    for private use    /----------";
echo "Press the Enter to start";
read start;


echo -e "\033[32m*updating sources....\033[0m";
sudo apt update;

echo -e "\033[32m*upgrading package....\033[0m";
sudo apt upgrade -y;

echo -e "\033[32m*backing up the ~/.bashrc file....\033[0m";
cp ~/.bashrc ~/.bashrc.bak;

echo -e "\033[32m*enabling color prompt for the terminal....\033[0m";
sed -i '0,/^#force_color_prompt=yes/ s/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc;

echo -e "\033[32m*configuring git base on Linux....\033[0m";
git config --global user.name "Ghost_bone";
git config --global user.email "ghost_bone@qq.com";
git config --global color.ui auto;
git config --global core.autocrlf input;
git config --global core.safecrlf true;
git config --global core.ignorecase true;
git config --global core.editor vim;

echo -e "\033[32m*configuring sshd for secure....\033[0m";
echo -e "Port 2222 \n\
Protocol 2 \n\
PermitRootLogin no \n\
PubkeyAuthentication yes \n\
RhostsAuthentication no \n\
IgnoreRhosts yes \n\
HostbasedAuthentication no \n\
IgnoreUserKnownHosts no \n\
PasswordAuthentication no \n\
PermitEmptyPasswords no \n\
PAMAuthenticationViaKbdInt no \n\
X11Forwarding no \n\
PrintMotd yes \n\
PrintLastLog yes \n\
KeepAlive yes \n" | sudo tee /etc/ssh/sshd_config.d/01-personal-config.conf;

echo -e "\033[32m*configuring the system timezone to Asia/Shanghai....\033[0m";
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;
echo "Asia/Shanghai" | sudo tee /etc/timezone;
sudo systemctl restart systemd-time*;

echo -e "\033[32m*configuring the maximum number of open files for better performance....\033[0m";
sudo sed -i '$ a\* soft nofile 204800\n* hard nofile 204800' /etc/security/limits.conf;
sudo sysctl -p;

echo -e "\033[32m*configuring the system char encoding and language to en_US.UTF-8....\033[0m";
echo 'LANG="en_US.UTF-8"' | sudo tee /etc/default/locale;

echo -e "\033[32m*configuring vim to always display line numbers....\033[0m";
echo ":set number" | sudo tee -a ~/.vimrc;

echo -e "\033[32m:-) All processes have been completed, \033[0m";
echo -e "\033[32mplease logout or reboot to take effect. \033[0m";
echo -e "\033[32mNext you should configure the DNS(*netplan) \033[0m";
