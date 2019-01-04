# Google Cloud Platform Deployment Manager

This directory contains all the resources necessary to deploy this demo to GCP.

## Resources
1. create 2 VMs
   * Both are running Edge Microgateway.
2. HTTP load balancer
   * NodeJS backend service
3. 1 instance groups
   * NodeJS instance group, which includes the Express Gateway
4. Firewall rules
5. Health checks
   * NodeJS gateway health check


## Deployment

Set your GCP project
```
gcloud config set project YOUR_GCP_PROJECT
gcloud config set compute/zone us-centra1-a
```

```
cd gcp-deployment-manager
chmod 777 *.sh
```

### Configure Edge Microgateway
* Configure Edge Microgateway as described in our [documentation](https://docs.apigee.com/api-platform/microgateway/2.5.x/setting-and-configuring-edge-microgateway#Part1).
* When you complete this step it will generate a
  * configuration file (YAML) that is named `org-env-config.yaml`, which should be located in `~/.edgemicro` on the machine where you executed the `edgemicro configure` command.
  * and it will also generate a key and secret that you need to start Edge Microgateway.  
* Copy your Microgateway config file (`org-env-config.yaml`) into the `gcp-deployment-manager/config` directory.
* Update the `gcp-deployment-manager/config/microgateway-startup.sh` file with your
  * Apigee Edge organization name
  * Apigee Edge environment name
  * Microgateway key
  * Microgateway secret
```
APIGEE_ORG=org
APIGEE_ENV=test
KEY=123
SECRET=12324
```

### Create the deployment
```
./deploy-all.sh apigee-migration-test
```

### Delete the deployment
```
./delete-deployment.sh apigee-migration-test
```


## Notes

### Adding/removing instances to an unmanaged instance group

[gcloud command documentation](https://cloud.google.com/compute/docs/instance-groups/creating-groups-of-unmanaged-instances#addinstances)

```
gcloud compute instance-groups unmanaged add-instances [INSTANCE_GROUP] \
  --instances [INSTANCE_NAME],[ANOTHER_INSTANCE_NAME] --zone us-central1-c
```

```
gcloud compute instance-groups unmanaged remove-instances [INSTANCE_GROUP] \
  --instances [INSTANCE_NAME],[ANOTHER_INSTANCE_NAME],[INSTANCES ...] --zone us-central1-c
```
