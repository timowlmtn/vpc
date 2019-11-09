# VPC
resource "aws_vpc" "owlmtn_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "owlmtn-vpc"
  }
}

# Subnets : public
resource "aws_subnet" "owlmtn_public_subnet" {
  count = "${length(var.public_subnet_cidr)}"
  vpc_id = "${aws_vpc.owlmtn_vpc.id}"
  cidr_block = "${element(var.public_subnet_cidr,count.index)}"
  availability_zone = "${element(var.azs,count.index)}"
  tags = {
    Name = "owlmtn-public-subnet-${count.index+1}"
  }
}

resource "aws_subnet" "owlmtn_private_lambda_subnet" {
    count = "${length(var.private_subnet_cidr)}"
    vpc_id = "${aws_vpc.owlmtn_vpc.id}"
    cidr_block = "${element(var.private_subnet_cidr,count.index)}"
    availability_zone = "${element(var.azs,count.index)}"

    tags = {
        Name = "owlmtn-private-lambda-subnet-${count.index+1}"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "owlmtn_igw" {
  vpc_id = "${aws_vpc.owlmtn_vpc.id}"
  tags = {
    Name = "owlmtn-igw"
  }
}


# Create the Security Group
resource "aws_security_group" "owlmtn_security_group" {
    vpc_id       = "${aws_vpc.owlmtn_vpc.id}"
    name         = "Open Access Tcp VPC Security"
    description  = "This will allow access through TCP to an internet gateway"
    ingress {
        cidr_blocks = "${var.ingressCIDRblock}"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
      }
    tags = {
            Name = "owlmtn-tcp-security-group"
      }
} # end resource


# Route table: attach Internet Gateway
resource "aws_route_table" "owlmtn_lambda_route_table" {
  vpc_id = "${aws_vpc.owlmtn_vpc.id}"
  tags = {
    Name = "owlmtn-private-lambda-nat-route"
  }
}
