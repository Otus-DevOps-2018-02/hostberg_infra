#!/usr/bin/env bash

cd ../terraform/stage/
terraform state pull > ../../ansible/terraform.tfstate

cd ../../ansible/
DB_HOST=`cat terraform.tfstate| jq -r '.modules[0] | .outputs | .db_internal_ip | .value'`
sed -i "" "s/^db_host.*/db_host: ${DB_HOST}/" ./group_vars/all
