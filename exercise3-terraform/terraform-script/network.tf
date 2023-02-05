# PROVIDERS
 provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region     = var.aws_region
 }

# DATA

data "aws_availability_zones" "available" {
  state = "available"
}

# RESOURCES

## NETWORKING

 resource "aws_vpc" "myVPC" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_hostnames = var.enable_dns_hostname
    tags                 = local.common_tags
 }

 resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myVPC.id
    tags   = local.common_tags
 }

resource "aws_subnet" "public_subnet1" {
    cidr_block              = var.subnet_cidr_block[0]
    vpc_id                  = aws_vpc.myVPC.id
    map_public_ip_on_launch = var.map_public_ip_on_launch
    availability_zone       = data.aws_availability_zones.available.names[0] 
    tags                    = local.common_tags
}

resource "aws_subnet" "public_subnet2" {
    cidr_block              = var.subnet_cidr_block[1]
    vpc_id                  = aws_vpc.myVPC.id
    map_public_ip_on_launch = var.map_public_ip_on_launch
    availability_zone       = data.aws_availability_zones.available.names[1] 
    tags                    = local.common_tags
}

resource "aws_subnet" "public_subnet3" {
    cidr_block              = var.subnet_cidr_block[2]
    vpc_id                  = aws_vpc.myVPC.id
    map_public_ip_on_launch = var.map_public_ip_on_launch
    availability_zone       = data.aws_availability_zones.available.names[2] 
    tags                    = local.common_tags
}


## ROUTING

resource "aws_route_table" "rtb" {
    vpc_id = aws_vpc.myVPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "rta_public_subnet1" {
    subnet_id      = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.rtb.id
}

resource "aws_route_table_association" "rta_public_subnet2" {
    subnet_id      = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.rtb.id
}

resource "aws_route_table_association" "rta_public_subnet3" {
    subnet_id      = aws_subnet.public_subnet3.id
    route_table_id = aws_route_table.rtb.id
}

## SECURITY GROUP

resource "aws_security_group" "guard" {   
    name   = "guard"
    vpc_id = aws_vpc.myVPC.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.vpc_cidr_block]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [var.vpc_cidr_block]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = local.common_tags
}

resource "aws_security_group" "alb_sg" {   
    name   = "alb_sg_guard"
    vpc_id = aws_vpc.myVPC.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = local.common_tags
}











