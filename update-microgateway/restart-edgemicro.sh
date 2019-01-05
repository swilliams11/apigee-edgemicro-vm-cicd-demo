#!/usr/bin/bash

EDGEMICRO_ORG=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_ORG"    -H "Metadata-Flavor: Google"`
EDGEMICRO_ENV=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_ENV"    -H "Metadata-Flavor: Google"`
EDGEMICRO_KEY=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_KEY"    -H "Metadata-Flavor: Google"`
EDGEMICRO_SECRET=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_SECRET"    -H "Metadata-Flavor: Google"`
EDGEMICRO_CONFIG=`curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/EDGEMICRO_CONFIG"    -H "Metadata-Flavor: Google"`

#start express gateway in the background
nohup edgemicro start -k $EDGEMICRO_KEY -s $EDGEMICRO_SECRET -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV  &
