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
### Elasticsearch
```sh
# deploy elasticsearch chart
$ helm upgrade --install elasticsearch elastic/elasticsearch --values elasticsearch/values.yaml
```
### Logstash
```sh
# deploy logstash chart
$ helm upgrade --install logstash elastic/logstash --values logstash/values.yaml
```

### Filebeat
```sh
# add security context privileged to filebeat service
# Note the project name being used (helm-demo)
$ oc adm policy add-scc-to-user privileged system:serviceaccount:helm-demo:filebeat-filebeat
# deploy filebeat chart
$ helm upgrade --install filebeat elastic/filebeat --values filebeat/values.yaml
```
### Kibana
```sh
# deploy kibana chart
$ helm upgrade --install kibana elastic/kibana --values kibana/values.yaml
```

