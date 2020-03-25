provider "aws" {
  version = "~> 2.0"  
  region  = "us-west-2"
}

#creando la vpc
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
      Name = "vpc_public"
  }
}

resource "aws_subnet" "subnet_course" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "10.0.15.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"

  tags = {
    Name = "Subnet_course_1"
  }
}

