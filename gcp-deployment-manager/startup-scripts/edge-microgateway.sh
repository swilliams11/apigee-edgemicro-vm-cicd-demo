#! /bin/bash

sudo mkdir /opt/nodejs
sudo curl https://nodejs.org/dist/v10.14.1/node-v10.14.1-linux-x64.tar.gz | sudo tar xvzf - -C /opt/nodejs --strip-components=1
sudo ln -s /opt/nodejs/bin/node /usr/bin/node
sudo ln -s /opt/nodejs/bin/npm /usr/bin/npm

sudo npm install -g edgemicro
#create the symlink
sudo ln -s /opt/nodejs/lib/node_modules/edgemicro/cli/edgemicro /usr/bin/edgemicro

#install monitoring agent and stackdriver agent
sudo curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
sudo bash install-monitoring-agent.sh

sudo curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

#start edgemicro gateway
cd ~

#fetch the config file from github
sudo curl https://raw.githubusercontent.com/swilliams11/apigee-edgemicro-vm-cicd-demo/master/gcp-deployment-manager/config/microgateway-startup.sh -o ~/microgateway-startup.sh
sudo chmod 777 microgateway-startup.sh
. microgateway-startup.sh

#start express gateway in the background
nohup edgemicro start -k $EDGEMICRO_KEY -s $EDGEMICRO_SECRET -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV  &
