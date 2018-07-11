# Internet VPC
resource "aws_vpc" "My-VPC-03-Scanner" {
  cidr_block           = "192.168.0.0/22"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "My-VPC-03-Scanner"
  }
}

# Subnets
resource "aws_subnet" "Private-Subnet-2" {
  vpc_id                  = "${aws_vpc.My-VPC-03-Scanner.id}"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "Public-Subnet02-Scanner"
  }
}

resource "aws_subnet" "Private-Subnet-1" {
  vpc_id                  = "${aws_vpc.My-VPC-03-Scanner.id}"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags {
    Name = "Public-Subnet01-Scanner"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.My-VPC-03-Scanner.id}"

  tags {
    Name = "My-VPC-03-Scanner"
  }
}

## Establishes a relationship resource between the "My-VPC-03-Scanner" and "My-VPC-01" VPC.

resource "aws_vpc_peering_connection" "My-VPC-03-Scanner2My-VPC-01" {
  peer_vpc_id = "${aws_vpc.My-VPC-01.id}"
  vpc_id      = "${aws_vpc.My-VPC-03-Scanner.id}"
  auto_accept = true
}

## Establishes a relationship resource between the "My-VPC-03-Scanner" and "My-VPC-02" VPC.

resource "aws_vpc_peering_connection" "My-VPC-03-Scanner2My-VPC-02" {
  peer_vpc_id = "${aws_vpc.My-VPC-02.id}"
  vpc_id      = "${aws_vpc.My-VPC-03-Scanner.id}"
  auto_accept = true
}

## Establishes a relationship resource between the "My-VPC-03-Scanner" and "Public-VPC-04" VPC.

resource "aws_vpc_peering_connection" "My-VPC-03-Scanner2Public-VPC-04" {
  peer_vpc_id = "${aws_vpc.Public-VPC-04.id}"
  vpc_id      = "${aws_vpc.My-VPC-03-Scanner.id}"
  auto_accept = true
}

# route tables
resource "aws_route_table" "main-public-01" {
  vpc_id = "${aws_vpc.My-VPC-03-Scanner.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  route {
    cidr_block                = "${aws_vpc.My-VPC-01.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.My-VPC-03-Scanner2My-VPC-01.id}"
  }

  route {
    cidr_block                = "${aws_vpc.My-VPC-02.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.My-VPC-03-Scanner2My-VPC-02.id}"
  }

  route {
    cidr_block                = "${aws_vpc.Public-VPC-04.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.My-VPC-03-Scanner2Public-VPC-04.id}"
  }

  tags {
    Name = "main-public-01"
  }
}

# route associations public
resource "aws_route_table_association" "Private-Subnet-1" {
  subnet_id      = "${aws_subnet.Private-Subnet-1.id}"
  route_table_id = "${aws_route_table.main-public-01.id}"
}

resource "aws_route_table_association" "Private-Subnet-2" {
  subnet_id      = "${aws_subnet.Private-Subnet-2.id}"
  route_table_id = "${aws_route_table.main-public-01.id}"
}

########################Private VPC01#########################################################
resource "aws_vpc" "My-VPC-01" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "My-VPC-01"
  }
}

# Subnets
resource "aws_subnet" "Private-Subnet-1-VPC01" {
  vpc_id                  = "${aws_vpc.My-VPC-01.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "Private-Subnet-1-VPC01"
  }
}

resource "aws_subnet" "Private-Subnet-2-VPC01" {
  vpc_id                  = "${aws_vpc.My-VPC-01.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1b"

  tags {
    Name = "Private-Subnet-2-VPC01"
  }
}

##Route Table for VPC01##

resource "aws_route_table" "vpc01-route" {
  vpc_id = "${aws_vpc.My-VPC-01.id}"

  route {
    cidr_block                = "${aws_vpc.My-VPC-03-Scanner.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.My-VPC-03-Scanner2My-VPC-01.id}"
  }

  tags {
    Name = "vpc01-route"
  }
}

# route associations private
resource "aws_route_table_association" "Private-Subnet-1-VPC01" {
  subnet_id      = "${aws_subnet.Private-Subnet-1-VPC01.id}"
  route_table_id = "${aws_route_table.vpc01-route.id}"
}

resource "aws_route_table_association" "Private-Subnet-2-VPC01" {
  subnet_id      = "${aws_subnet.Private-Subnet-2-VPC01.id}"
  route_table_id = "${aws_route_table.vpc01-route.id}"
}

########################Private VPC02#########################################################
resource "aws_vpc" "My-VPC-02" {
  cidr_block           = "172.16.0.0/22"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "My-VPC-02"
  }
}

# Subnets
resource "aws_subnet" "Private-Subnet-1-VPC02" {
  vpc_id                  = "${aws_vpc.My-VPC-02.id}"
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "Private-Subnet-1-VPC02"
  }
}

resource "aws_subnet" "Private-Subnet-2-VPC02" {
  vpc_id                  = "${aws_vpc.My-VPC-02.id}"
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1b"

  tags {
    Name = "Private-Subnet-2-VPC02"
  }
}

##Route Table for VPC02##

resource "aws_route_table" "vpc02-route" {
  vpc_id = "${aws_vpc.My-VPC-02.id}"

  route {
    cidr_block                = "${aws_vpc.My-VPC-03-Scanner.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.My-VPC-03-Scanner2My-VPC-02.id}"
  }

  tags {
    Name = "vpc02-route"
  }
}

# route associations private
resource "aws_route_table_association" "Private-Subnet-1-VPC02" {
  subnet_id      = "${aws_subnet.Private-Subnet-1-VPC02.id}"
  route_table_id = "${aws_route_table.vpc02-route.id}"
}

resource "aws_route_table_association" "Private-Subnet-2-VPC02" {
  subnet_id      = "${aws_subnet.Private-Subnet-2-VPC02.id}"
  route_table_id = "${aws_route_table.vpc02-route.id}"
}

##########################################Public-VPC-04################################
# Public-VPC-04
resource "aws_vpc" "Public-VPC-04" {
  cidr_block           = "172.28.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "Public-VPC-04"
  }
}

# Subnets
resource "aws_subnet" "Public-Subnet-1-VPC04" {
  vpc_id                  = "${aws_vpc.Public-VPC-04.id}"
  cidr_block              = "172.28.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "Public-Subnet-1-VPC04"
  }
}

resource "aws_subnet" "Public-Subnet-2-VPC04" {
  vpc_id                  = "${aws_vpc.Public-VPC-04.id}"
  cidr_block              = "172.28.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags {
    Name = "Public-Subnet-2-VPC04"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw-vpc04" {
  vpc_id = "${aws_vpc.Public-VPC-04.id}"

  tags {
    Name = "Public-VPC-04"
  }
}

# route tables
resource "aws_route_table" "Public-VPC-04" {
  vpc_id = "${aws_vpc.Public-VPC-04.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw-vpc04.id}"
  }

  route {
    cidr_block                = "${aws_vpc.My-VPC-03-Scanner.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.My-VPC-03-Scanner2Public-VPC-04.id}"
  }

  tags {
    Name = "Public-VPC-04"
  }
}

# route associations public
resource "aws_route_table_association" "Public-Subnet-1-VPC04" {
  subnet_id      = "${aws_subnet.Public-Subnet-1-VPC04.id}"
  route_table_id = "${aws_route_table.Public-VPC-04.id}"
}

resource "aws_route_table_association" "Public-Subnet-2-VPC04" {
  subnet_id      = "${aws_subnet.Public-Subnet-2-VPC04.id}"
  route_table_id = "${aws_route_table.Public-VPC-04.id}"
}
