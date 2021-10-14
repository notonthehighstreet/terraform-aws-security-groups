# set the security group id here
# we dont have to change all of the code later
# if this sg changes, just need to change this variable.
locals {
  ingress_rules = var.allow_rules.ingress_rules
  egress_rules  = var.allow_rules.egress_rules
}
