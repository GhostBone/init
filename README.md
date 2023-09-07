# Ubuntu自定义初始化环境步骤
----------


### -- 0x01 更新源

```bash
sudo apt update
```


### -- 0x02 升级所有软件包

```bash
sudo apt upgrade -y
```


### -- 0x03 本用户的256色
```bash
cp ~/.bashrc ~/.bashrc.bak
sed -i '0,/^#force_color_prompt=yes/ s/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc
```


### -- 0x04 配置git
```bash
git config --global user.name "Ghost_bone"
git config --global user.email "ghost_bone@qq.com"
git config --global color.ui auto
git config --global core.autocrlf input;
git config --global core.safecrlf true;
git config --global core.ignorecase true
git config --global core.editor vim;
sudo systemctl restart sshd.service;
```


### -- 0x05 配置ssh
```bash
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
KeepAlive yes \n" | sudo tee /etc/ssh/sshd_config.d/01-personal-config.conf
```


### --  0x06 设置时区
```bash
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" | sudo tee /etc/timezone
sudo systemctl restart systemd-time*
```


### -- 0x07 修改最大打开文件数
```bash
sudo sed -i '$ a\* soft nofile 204800\n* hard nofile 204800' /etc/security/limits.conf
sudo sysctl -p
```


### -- 0x08 修改系统默认编码和语言
```bash
echo 'LANG="en_US.UTF-8"' | sudo tee /etc/default/locale
```


### --  0x09 vim默认显示行号
```bash
echo ":set number" | sudo tee -a ~/.vimrc
```
