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

resource "aws_internet_gateway" "gw_course" {
  vpc_id = "${aws_vpc.example.id}"
  tags = {
    Name = "gtw_course"
  }
}

resource "aws_route_table" "rtb_course" {
  vpc_id = "${aws_vpc.example.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw_course.id}"
  }  
    tags = {
      Name = "rtbl_course"
    }
}

resource "aws_route_table_association" "rtbl_course_subnet_1" {
  subnet_id = "${aws_subnet.subnet_course.id}"
  route_table_id = "${aws_route_table.rtb_course.id}"
}

