output "k8s-cluster" {
  value = "${join("\n", aws_instance.k8s-cluster.*.public_dns)}"
}
