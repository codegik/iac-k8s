resource "aws_instance" "k8s-cluster-master-01" {
  ami = "${var.AWS_DEFAULT_AMI}"
  instance_type = "${var.AWS_DEFAULT_INSTANCE_TYPE}"
  key_name = "${var.AWS_KEY_PAIR_NAME}"
  tags = {
    Name = "k8s-cluster-master-01"
  }
}

resource "aws_instance" "k8s-cluster-master-02" {
  ami = "${var.AWS_DEFAULT_AMI}"
  instance_type = "${var.AWS_DEFAULT_INSTANCE_TYPE}"
  key_name = "${var.AWS_KEY_PAIR_NAME}"
  tags = {
    Name = "k8s-cluster-master-02"
  }
}

resource "aws_instance" "k8s-cluster-app-01" {
  ami = "${var.AWS_DEFAULT_AMI}"
  instance_type = "${var.AWS_DEFAULT_INSTANCE_TYPE}"
  key_name = "${var.AWS_KEY_PAIR_NAME}"
  tags = {
    Name = "k8s-cluster-app-01"
  }
}

resource "aws_instance" "k8s-app-02" {
  ami = "${var.AWS_DEFAULT_AMI}"
  instance_type = "${var.AWS_DEFAULT_INSTANCE_TYPE}"
  key_name = "${var.AWS_KEY_PAIR_NAME}"
  tags = {
    Name = "k8s-cluster-app-02"
  }
}
