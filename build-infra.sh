#!/bin/sh

################ Altere estas variáveis ###################
USER_SSH_PRIVATE_KEY=""
AWS_USER="ubuntu"
AWS_ACCESS_KEY=""
AWS_SECRET_KEY=""
###########################################################




set -e

########## Provisiona instancias e configurações cloud #######
cd terraform
terraform init
terraform plan -var AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
               -var AWS_SECRET_KEY=${AWS_SECRET_KEY}
terraform apply -auto-approve -var AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
                              -var AWS_SECRET_KEY=${AWS_SECRET_KEY}

k8s_cluster_host=$(terraform output k8s-cluster)

echo "${k8s_cluster_host}"

############## Provisiona e configura as ferramentas #########
# cd ../ansible
# echo "" > hosts
# echo "[mongodb]" >> hosts
# echo "${mongodb_host}" >> hosts
# echo "" >> hosts
# echo "[jenkins]" >> hosts
# echo "${jenkins_host}" >> hosts
# echo "" >> hosts
# echo "[all:vars]" >> hosts
# echo "ansible_python_interpreter=/usr/bin/python3" >> hosts
# echo "ansible_user=${AWS_USER}" >> hosts
# echo "ansible_ssh_private_key_file=${USER_SSH_PRIVATE_KEY}" >> hosts

# ansible-playbook mongodb-playbook.yml -i hosts --extra-vars="AWS_DEFAULT_INSTANCE_TYPE=${AWS_DEFAULT_INSTANCE_TYPE} AWS_ACCESS_KEY=${AWS_ACCESS_KEY} AWS_SECRET_KEY=${AWS_SECRET_KEY} AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"
# ansible-playbook jenkins-playbook.yml -i hosts --extra-vars="AWS_DEFAULT_INSTANCE_TYPE=${AWS_DEFAULT_INSTANCE_TYPE} AWS_ACCESS_KEY=${AWS_ACCESS_KEY} AWS_SECRET_KEY=${AWS_SECRET_KEY} AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"

exit 0