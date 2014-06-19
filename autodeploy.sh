################################################################################
################################################################################
################################################################################
#sh autodeploy.sh
#!/usr/bin/env bash

#install git
#sudo apt-get install git

sudo apt-get update

#install upstart
sudo apt-get install upstart
#install nginx
sudo apt-get install nginx

#install docker
sudo apt-get install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

#install node
sudo apt-get install nodejs
sudo apt-get install npm

#create firewall
sudo cp ~/myr-build/iptables.firewall.rules /etc/iptables.firewall.rules
sudo iptables-restore < /etc/iptables.firewall.rules
sudo cp ~/myr-build/firewall /etc/network/if-pre-up.d/firewall
sudo chmod +x /etc/network/if-pre-up.d/firewall

#install fail2ban, prevents several retries into server
sudo apt-get install fail2ban

#get app
mkdir ~/ #translates to /home/[user]/
cd ~/
sudo git clone https://github.com/thecaddy/qarth-dock
cd qarth-dock
#install gith
sudo npm install


#copy upstart to /etc/init/
sudo cp ~/myr-build/qarth-dock.conf /etc/init/qarth-dock.conf

#setup log for user
#sudo mkdir /var/log/hook
#sudo chown thecaddy:thecaddy /var/log/hook

#sets root on deploy.sh
#add this to /etc/sudoers
#thecaddy ALL=NOPASSWD:/home/thecaddy/myr-build/deploy.sh

#start the upstart service
sudo start qarth-dock



################################################################################
################################################################################
################################################################################
