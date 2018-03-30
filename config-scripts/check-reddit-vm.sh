#!/bin/bash

EXTERNAL_IP=`gcloud compute instances list --filter="name=('reddit-full')" \
--format="value(networkInterfaces[0].accessConfigs[0].natIP)"`

curl --silent http://${EXTERNAL_IP}:9292 2>&1 | egrep --quiet 'Monolith Reddit' \
&& echo "Test: OK" || echo "Test: Fail"
