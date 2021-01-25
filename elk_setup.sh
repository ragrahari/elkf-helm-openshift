#!/bin/bash
echo "Add the helm repo"
helm repo add elastic https://helm.elastic.co
echo "Install Elastic Search"
helm upgrade --install elasticsearch elastic/elasticsearch --values elasticsearch/values.yaml
echo "Install Logstash"
helm upgrade --install logstash elastic/logstash --values logstash/values.yaml
echo "Install Kibana"
helm upgrade --install kibana elastic/kibana --values kibana/values.yaml
echo "Install Filebeat"
helm upgrade --install filebeat elastic/filebeat --values filebeat/values.yaml
oc adm policy add-scc-to-user privileged system:serviceaccount:logging:filebeat-filebeat
echo "Setup completed."

echo "Expose Kibana Service"
oc expose svc kibana-kibana