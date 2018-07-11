resource "aws_instance" "UbuntuServer-VPC03-Scanner" {
  ami           = "ami-a26d53db"
  instance_type = "t2.micro"

  tags {
    Name = "UbuntuServer-VPC03-Scanner"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.Private-Subnet-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-VPC03-Scanner.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

resource "aws_instance" "WiServer-2012-VPC03-Scanner" {
  ami           = "ami-3e7a7647"
  instance_type = "t2.micro"

  tags {
    Name = "WiServer-2012-VPC03-Scanner"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.Private-Subnet-2.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-VPC03-Scanner.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

########Instances under VPC02############################i

resource "aws_instance" "WiServer01-2012-VPC02" {
  ami           = "ami-3e7a7647"
  instance_type = "t2.micro"

  tags {
    Name = "WiServer-2012-VPC02"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.Private-Subnet-1-VPC02.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-VPC02.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

resource "aws_instance" "WiServer02-2012-VPC02" {
  ami           = "ami-3e7a7647"
  instance_type = "t2.micro"

  tags {
    Name = "WiServer-2012-VPC02"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.Private-Subnet-2-VPC02.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-VPC02.id}"]

 # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

########Instances under VPC01############################i

resource "aws_instance" "RHEL-VPC01" {
  ami           = "ami-7c491f05"
  instance_type = "t2.micro"

  tags {
    Name = "RHEL-VPC01"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.Private-Subnet-1-VPC01.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-VPC01.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

resource "aws_instance" "SUSE-VPC01" {
  ami           = "ami-52251b2b"
  instance_type = "t2.micro"

  tags {
    Name = "SUSE-VPC01"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.Private-Subnet-2-VPC01.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-VPC01.id}"]

 # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}
