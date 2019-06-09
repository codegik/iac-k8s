#!/bin/sh
set -e

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <USER_SSH_PRIVATE_KEY> <AWS_ACCESS_KEY> <AWS_SECRET_KEY>"
    exit 1
fi

AWS_USER="ubuntu"
USER_SSH_PRIVATE_KEY="$1"
AWS_ACCESS_KEY="$2"
AWS_SECRET_KEY="$3"

########## Cloud provision #######
cd terraform
terraform init
terraform plan -var AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
               -var AWS_SECRET_KEY=${AWS_SECRET_KEY}
terraform apply -auto-approve -var AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
                              -var AWS_SECRET_KEY=${AWS_SECRET_KEY}

k8s_cluster_master_01=$(terraform output k8s-cluster-master-01)
k8s_cluster_master_02=$(terraform output k8s-cluster-master-02)
k8s_cluster_app_01=$(terraform output k8s-cluster-app-01)
k8s_cluster_app_02=$(terraform output k8s-cluster-app-02)

echo "${k8s_cluster_master_01}"
echo "${k8s_cluster_master_02}"
echo "${k8s_cluster_app_01}"
echo "${k8s_cluster_app_02}"

############## Ansible scripts #########
cd ../ansible
echo "" > hosts
echo "[k8s-cluster-master-01]" >> hosts
echo "${k8s_cluster_master_01}" >> hosts
echo "[k8s-cluster-master-02]" >> hosts
echo "${k8s_cluster_master_02}" >> hosts
echo "[k8s-cluster-app-01]" >> hosts
echo "${k8s_cluster_app_01}" >> hosts
echo "[k8s-cluster-app-02]" >> hosts
echo "${k8s_cluster_app_02}" >> hosts
echo "" >> hosts
echo "[all:vars]" >> hosts
echo "ansible_python_interpreter=/usr/bin/python3" >> hosts
echo "ansible_user=${AWS_USER}" >> hosts
echo "ansible_ssh_private_key_file=${USER_SSH_PRIVATE_KEY}" >> hosts

exit 0