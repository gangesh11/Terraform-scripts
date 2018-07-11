resource "aws_security_group" "SG-VPC03-Scanner" {
  vpc_id = "${aws_vpc.My-VPC-03-Scanner.id}"
  name = "SG-VPC03-Scanner"
  description = "security group-VPC03"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["192.168.60.10/32"]
  }
ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["61.95.254.10/32"]
  }

tags {
    Name = "allow-ssh"
  }
}

resource "aws_security_group" "SG-VPC02" {
  vpc_id = "${aws_vpc.My-VPC-02.id}"
  name = "SG-VPC02"
  description = "security group-VPC02"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["192.168.0.0/22"]
  }
tags {
    Name = "allow traffic from vpc03"
  }
}

resource "aws_security_group" "SG-VPC01" {
  vpc_id = "${aws_vpc.My-VPC-01.id}"
  name = "SG-VPC01"
  description = "security group-VPC01"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["192.168.0.0/22"]
  }
tags {
    Name = "allow traffic from vpc03"
  }
}


