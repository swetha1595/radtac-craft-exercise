mkdir userdata
cd /userdata			
[ec2-user@ip-172-31-40-200 userdata]$ cat httpd.sh
#!/bin/bash
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd

vi main.tf
==========
provider "aws" {
  region     = "us-east-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
resource "aws_instance" "venkatesh" {
  count	          = "${var.instance}"
  ami             = "${var.ami}"
  instance_type   = "t2.micro"
  security_groups = [""]
  key_name        = "${var.key_name}"
  user_data       = "${file("httpd.sh")}"	
  tags = {
    Name = "jenkins-${count.index}"
  }
}
variable.tf
============
variable "ami" {
  description = "ami"
 default = ""
 }
variable "access_key"{
  default = ""
  }
variable "secret_key"{
  default = ""
  }
variable "key_name"{
  default = ""
  }
variable "instance" {
  default = "1"
} 





ok na