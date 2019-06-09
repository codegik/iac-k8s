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
