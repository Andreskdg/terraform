provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "principal" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.principal.id
}

resource "aws_subnet" "subnet_publica_1" {
  vpc_id=aws_vpc.principal.id
  cidr_block="10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_publica_2" {
  vpc_id=aws_vpc.principal.id
  cidr_block="10.0.2.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "subnet_privada_1" {
  vpc_id=aws_vpc.principal.id
  cidr_block="10.0.3.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_privada_2" {
  vpc_id=aws_vpc.principal.id
  cidr_block="10.0.4.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_route_table" "tabla_rutas_publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "asociacion_publica_1" {
  subnet_id      = aws_subnet.subnet_publica_1.id
  route_table_id = aws_route_table.tabla_rutas_publica.id
}

resource "aws_route_table_association" "asociacion_publica_2" {
  subnet_id      = aws_subnet.subnet_publica_2.id
  route_table_id = aws_route_table.tabla_rutas_publica.id
}

