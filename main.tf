# set the security group id here
# we dont have to change all of the code later
# if this sg changes, just need to change this variable.
locals {
  ingress_rules = var.allow_rules.ingress_rules
  egress_rules  = var.allow_rules.egress_rules
}

# just use a named sg for now - we can expand this later if required
resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags

  dynamic "ingress" {
    iterator = rule
    for_each = flatten([for rule in local.ingress_rules:
    rule if rule.type == "ingress_cidr_blocks"])
    content {
      from_port   = rule.value.from_port
      to_port     = rule.value.to_port
      protocol    = rule.value.protocol
      description = rule.value.description
      cidr_blocks = rule.value.allow
      self        = var.enable_self
    }
  }

  dynamic "egress" {
    iterator = rule
    for_each = flatten([for rule in local.egress_rules:
    rule if rule.type == "egress_cidr_blocks"])
    content {
      from_port       = rule.value.from_port
      to_port         = rule.value.to_port
      protocol        = rule.value.protocol
      description     = rule.value.description
      cidr_blocks     = rule.value.allow
      prefix_list_ids = var.egress_prefix_list_ids
      self            = var.enable_self
    }
  }

  dynamic "ingress" {
    iterator = rule
    for_each = flatten([for rule in local.ingress_rules:
    rule if rule.type == "ingress_source_security_groups"])
    content {
      from_port       = rule.value.from_port
      to_port         = rule.value.to_port
      protocol        = rule.value.protocol
      description     = rule.value.description
      security_groups = rule.value.allow
    }
  }

  dynamic "egress" {
    iterator = rule
    for_each = flatten([for rule in local.egress_rules:
    rule if rule.type == "egress_source_security_groups"])
    content {
      from_port       = rule.value.from_port
      to_port         = rule.value.to_port
      protocol        = rule.value.protocol
      description     = rule.value.description
      security_groups = rule.value.allow
      prefix_list_ids = var.egress_prefix_list_ids
    }
  }
}

