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

########## Get cloud info #######
cd terraform
k8s_cluster_master_01=$(terraform output k8s-cluster-master-01)
k8s_cluster_master_02=$(terraform output k8s-cluster-master-02)
k8s_cluster_app_01=$(terraform output k8s-cluster-app-01)
k8s_cluster_app_02=$(terraform output k8s-cluster-app-02)
AWS_DEFAULT_REGION=$(terraform output AWS_DEFAULT_REGION)
AWS_DEFAULT_INSTANCE_TYPE=$(terraform output AWS_DEFAULT_INSTANCE_TYPE)


############## Create ansible inventory #########
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
echo "[k8s-cluster]" >> hosts
echo "${k8s_cluster_master_01}" >> hosts
echo "${k8s_cluster_master_02}" >> hosts
echo "${k8s_cluster_app_01}" >> hosts
echo "${k8s_cluster_app_02}" >> hosts

echo "" >> hosts
echo "[k8s-cluster-master]" >> hosts
echo "${k8s_cluster_master_01}" >> hosts
echo "${k8s_cluster_master_02}" >> hosts

echo "" >> hosts
echo "[k8s-cluster-app]" >> hosts
echo "${k8s_cluster_app_01}" >> hosts
echo "${k8s_cluster_app_02}" >> hosts

echo "" >> hosts
echo "[all:vars]" >> hosts
echo "ansible_python_interpreter=/usr/bin/python3" >> hosts
echo "ansible_user=${AWS_USER}" >> hosts
echo "ansible_ssh_private_key_file=${USER_SSH_PRIVATE_KEY}" >> hosts

############## Running ansible scripts #########

ansible-playbook k8s-cluster.yml -i hosts \
    --ssh-common-args='-o StrictHostKeyChecking=no' \
    --extra-vars="AWS_DEFAULT_INSTANCE_TYPE=${AWS_DEFAULT_INSTANCE_TYPE} AWS_ACCESS_KEY=${AWS_ACCESS_KEY} AWS_SECRET_KEY=${AWS_SECRET_KEY} AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"

exit 0