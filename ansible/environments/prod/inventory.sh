#!/usr/bin/env bash

ENV=prod

cd ../terraform/${ENV}
terraform state pull > ../../ansible/environments/${ENV}/terraform.tfstate

cd ../../ansible/
DB_HOST=`cat ./environments/${ENV}/terraform.tfstate| jq -r '.modules[0] | .outputs | .db_internal_ip | .value'`
sed -i "" "s/^db_host.*/db_host: ${DB_HOST}/" ./environments/${ENV}/group_vars/app

/usr/local/bin/terraform-inventory $@ ./environments/${ENV}/terraform.tfstate
