variable "AWS_ACCESS_KEY" {} 
variable "AWS_SECRET_KEY" {} 
variable "AWS_PUBLIC_SUBNET" {} 
variable "AWS_DEFAULT_VPC" {} 
variable "AWS_DEFAULT_AMI" {}
variable "AWS_DEFAULT_INSTANCE_TYPE" {}
variable "AWS_DEFAULT_REGION" {}
variable "AWS_KEY_PAIR_NAME" {}
variable "AWS_PUBLIC_KEY" {}

provider "aws" {
  region = "${var.AWS_DEFAULT_REGION}"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_key_pair" "key-pair" {
  key_name = "${var.AWS_KEY_PAIR_NAME}"
  public_key = "${var.AWS_PUBLIC_KEY}"
}
