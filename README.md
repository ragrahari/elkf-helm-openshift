# elastic-stack-helm-openshift
Playground repository to deploy some helm charts to openshift

## Requirements
- helm installed
- openshift admin access

## Setup
```sh
# Add elastic helm charts repo 
$ helm repo add elastic https://helm.elastic.co
```

## Deployment
To Deploy the whole stack, run the `elk_setup.sh` script. Make sure you have created a namespace `logging` before you run the setup script.
```sh
# Make sure you have created logging namespace
$ oc new-project logging --display-name='Logging'
# Run the ELK setup script to install the stack. 
$ ./elk_setup.sh
```

### Elasticsearch
Individual Elasticsearch deployment or upgrade.
```sh
# deploy elasticsearch chart
$ helm upgrade --install elasticsearch elastic/elasticsearch --values elasticsearch/values.yaml
```
### Logstash
Individual Logstash deployment or upgrade.
```sh
# deploy logstash chart
$ helm upgrade --install logstash elastic/logstash --values logstash/values.yaml
```

### Filebeat
Individual Filebeat deployment or upgrade.
```sh
# deploy filebeat chart
$ helm upgrade --install filebeat elastic/filebeat --values filebeat/values.yaml
# add security context privileged to filebeat service
# Note the project name being used - logging
$ oc adm policy add-scc-to-user privileged system:serviceaccount:logging:filebeat-filebeat
```
### Kibana
Individual Kibana deployment or upgrade.
```sh
# deploy kibana chart
$ helm upgrade --install kibana elastic/kibana --values kibana/values.yaml
```

## Cleanup 
To cleanup the ELK stack:

- Uninstall ELK and Filebeat Helm releases.
- Delete Kibana Route
- Optionally, release PVCs. Do not release PVCs if you want to keep the Elasticsearch logs.

```sh
# Make sure you are in logging namespace
$ oc project logging
# Run the ELK setup script to install the stack. 
$ ./elk_cleanup.sh
```