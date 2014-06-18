################################################################################
################################################################################
################################################################################
#sh autodeploy.sh
#!/usr/bin/env bash

#install git
sudo apt-get install git

#install upstart
sudo apt-get install upstart

#install docker
sudo apt-get update
sudo apt-get install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

#install node
sudo apt-get install nodejs
sudo apt-get install npm

# (I)nserts this rule after the 4th iptables firewall rule
sudo iptables -I INPUT 4 -p tcp --dport 9003 -j ACCEPT

#get app
mkdir ~/ #translates to /home/[user]/
cd ~/
sudo git clone https://github.com/thecaddy/qarth-dock
cd qarth-dock
#install gith
sudo npm install


#copy upstart to /etc/init/
sudo cp ~/qarth-dock/qarth-dock.conf /etc/init/qarth-dock.conf

#setup log for user
#sudo mkdir /var/log/hook
#sudo chown thecaddy:thecaddy /var/log/hook

#start the server with forever wrapper
sudo nodejs server-start.js

################################################################################
################################################################################
################################################################################
