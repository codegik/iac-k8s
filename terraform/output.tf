output "k8s-cluster-master-01" {
  value = "${join("\n", aws_instance.k8s-cluster-master-01.*.public_dns)}"
}

output "k8s-cluster-master-02" {
  value = "${join("\n", aws_instance.k8s-cluster-master-02.*.public_dns)}"
}

output "k8s-cluster-app-01" {
  value = "${join("\n", aws_instance.k8s-cluster-app-01.*.public_dns)}"
}

output "k8s-cluster-app-02" {
  value = "${join("\n", aws_instance.k8s-cluster-app-02.*.public_dns)}"
}

output "AWS_DEFAULT_REGION" {
  value = "${var.AWS_DEFAULT_REGION}"
}

output "AWS_DEFAULT_INSTANCE_TYPE" {
  value = "${var.AWS_DEFAULT_INSTANCE_TYPE}"
}
