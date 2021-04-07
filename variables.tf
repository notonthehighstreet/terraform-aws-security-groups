variable "name" {
}

variable "description" {
}

variable "vpc_id" {
}

variable "ingress_rule" {
  type    = list(any)
  default = []
}

variable "allow_rules" {
  type = map(list(object({
    from_port   = number
    to_port     = number
    description = string
    protocol    = string
    type        = string
    allow = list(string)
  })))
}

variable "egress_rule" {
  type        = list(any)
  default     = []
  description = "This takes 3 values: from_port, to_port, protocol, these are then individually fed into sg rule"
}

variable "ingress_source_sg" {
  type    = string
  default = ""
}

variable "egress_source_sg" {
  type    = string
  default = ""
}

variable "ingress_cidr_blocks" {
  type    = list(any)
  default = []
}

variable "ingress_prefix_list_ids" {
  type    = list(any)
  default = []
}

variable "egress_cidr_blocks" {
  type    = list(any)
  default = []
}

variable "egress_prefix_list_ids" {
  type    = list(any)
  default = []
}

variable "egress_allow_all" {
  default     = false
  description = "If enabled, a default allow all egress rule is also added. allowing all traffic out"
}

variable "enable_self" {
  default     = false
  description = "If enabled, allow internal traffic from/to itself (only works with cidr based rules)"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "sg_id" {
  default = ""
}

