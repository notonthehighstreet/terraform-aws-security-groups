provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = "~> 0.12.1"
}

resource "aws_vpc" "mgmt" {
  cidr_block = "172.16.0.0/16"
  tags       = {
    Name = "tf-0.12-dynamic-block-example"
  }
}

variable "cidr_list" {
  default = {
    global  = [
      "0.0.0.0/0"
    ],
    example = [
      "192.168.1.1/24",
      "192.168.2.1/24",
      "192.168.3.1/24"
    ]
  }
}

variable "global_cidr_list" {
}

module "example_security_group" {
  source      = "../"
  name        = "example_access"
  description = "Example Access to SSH and HTTPS"
  vpc_id      = aws_vpc.mgmt.id

  allow_rules = {
    ingress_rules = [
      {
        from_port   = "443"
        to_port     = "443"
        protocol    = "tcp"
        description = "example_https_ingress_access"
        type        = "ingress_cidr_blocks"
        allow = var.cidr_list.example
      },
      {
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        description = "example_ssh_ingress_access"
        type        = "ingress_cidr_blocks"
        allow = var.cidr_list.example
      }
    ],
    egress_rules  = [
      {
        from_port   = "443"
        to_port     = "443"
        protocol    = "tcp"
        description = "example_https_egress_access"
        type        = "egress_cidr_blocks"
        allow = var.cidr_list.example
      },
      {
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        description = "example_ssh_egress_access"
        type        = "egress_cidr_blocks"
        allow = var.cidr_list.example
      },
      {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        description = "example_allow_all_egress_access"
        type        = "egress_cidr_blocks"
        allow = var.cidr_list.global
      }
    ]
  }

  tags = {
    Name = "example_security_group_access"
  }
}