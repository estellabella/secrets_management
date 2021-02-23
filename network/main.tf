provider "aws" {
  region = var.region
}


resource "aws_vpc" "prodvpc" {
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "prodvpc"
  }
}


resource "aws_subnet" "private-sb" {
  vpc_id     = aws_vpc.prodvpc.id
  cidr_block = "172.31.1.0/24"

  tags = {
    Name = "private-sb"
  }
}


resource "aws_subnet" "public-sb" {
  vpc_id     = aws_vpc.prodvpc.id
  cidr_block = "172.31.2.0/24"

  tags = {
    Name = "public-sb"
  }
}

resource "aws_subnet" "dsg-sb" {
  vpc_id     = aws_vpc.prodvpc.id
  cidr_block = "172.31.3.0/24"

  tags = {
    Name = "dsg-sb"
  }
}


resource "aws_subnet" "ent-sb" {
  vpc_id     = aws_vpc.prodvpc.id
  cidr_block = "172.31.4.0/24"

  tags = {
    Name = "ent-sb"
  }
}
