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

EDGEMICRO_ORG=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_ORG"    -H "Metadata-Flavor: Google"`
EDGEMICRO_ENV=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_ENV"    -H "Metadata-Flavor: Google"`
EDGEMICRO_KEY=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_KEY"    -H "Metadata-Flavor: Google"`
EDGEMICRO_SECRET=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_SECRET"    -H "Metadata-Flavor: Google"`
EDGEMICRO_CONFIG=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_CONFIG"    -H "Metadata-Flavor: Google"`
sudo mkdir .edgemicro
sudo echo $EDGEMICRO_CONFIG | base64 -d >> .edgemicro/$EDGEMICRO_ORG-$EDGEMICRO_ENV-config.yaml

#start express gateway in the background
nohup edgemicro start -k $EDGEMICRO_KEY -s $EDGEMICRO_SECRET -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV  &
