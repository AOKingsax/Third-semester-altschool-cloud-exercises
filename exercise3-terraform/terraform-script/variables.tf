variable "aws_access_key" {
    type = string
    description = "AWS access key"
    sensitive = true
}

variable "aws_secret_key" {
    type = string
    description = "AWS secret key"
    sensitive = true
}

variable "aws_region" {
    type = string
    description = "AWS region"
    default = "us-east-1"
}

variable "vpc_cidr_block" {
    type = string
    description = "Base cidr block for vpc"
    default = "10.0.0.0/16"
}

variable "enable_dns_hostname" {
    type = bool
    description = "Enable DNS hostname in vpc"
    default = true
}

variable "subnet_cidr_block" {
    type = list(string)
    description = "Cidr blocks for subnet in vpc"
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "map_public_ip_on_launch" {
    type = string
    description = "Map a public IP address on subnet"
    default = true
}

variable "image_id" {
    type = string
    description = "ami image id"
    default = "ami-00874d747dde814fa"
}

variable "instance_type" {
    type = string
    description = "Instance type"
    default = "t2.micro"
}

variable "company" {
    type = string
    description = "Company name for resource tagging"
    default = "Altschool"
}

variable "project" {
    type = string
    description = "project name for resource tagging"
}

variable "domain_name" {
    type = string
    description = "domain name"
    default = "kingsax.me"
}








