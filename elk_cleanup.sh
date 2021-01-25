#!/bin/bash
echo "Switch to the logging namespace"
oc project logging
echo "View Repos setup with Helm"
helm list
echo "Uninstall Elastic Search"
helm uninstall elasticsearch
echo "Uninstall Logstash"
helm uninstall logstash
echo "Uninstall Kibana"
helm uninstall kibana
echo "Uninstall Filebeat"
helm uninstall filebeat
echo "Delete Kibana Route"
oc delete route kibana-kibana
echo "PVC cleanup is skipped for persistence of data."
echo "To release PVCs, run \"oc delete pvc -l app=elasticsearch-master\""
echo "Cleanup completed."
