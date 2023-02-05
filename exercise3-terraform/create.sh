#!/bin/bash

# scipt to run terraform and ansible scripts together

cd terraform-script
terraform init
terraform plan -out save.tfplan
terraform apply "save.tfplan"

cd ..
cd ansible-script
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i host-inventory.txt deploy-server.yml --private-key=key.pem
