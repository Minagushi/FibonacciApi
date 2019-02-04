provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.credentials_file}"
  profile = "${var.profile}"
}
data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}
resource "aws_security_group" "websg" {
  name ="webserver-websg"
ingress {
  from_port = "80"
  to_port = "80"
  protocol ="tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
ingress {
  from_port = "22"
  to_port = "22"
  protocol ="tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
egress{
 from_port = "0"
 to_port = "0"
 protocol ="-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
}
resource "aws_instance" "web" {
  ami                         = "${data.aws_ami.amzn.id}"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.websg.id}"]
  tags = {
    Name    = "webserver"
    sshUser = "ec2-user"
  }
  provisioner "remote-exec" {
    inline = ["sudo yum -y install python"]

    connection {
      type        = "ssh"
      user        = "${aws_instance.web.tags.sshUser}"
      private_key = "${file(var.ssh_key_private)}"
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -u '${aws_instance.web.tags.sshUser}' -i ${self.public_ip}, --private-key ${var.ssh_key_private} playbook.yml" 
  }
}
output "test link" {
  value = "http://${aws_instance.web.public_dns}/api/fib?n=10"
}