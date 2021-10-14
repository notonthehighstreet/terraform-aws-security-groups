variable "security_group" {
 type = object({
   name = string
   description = string
   vpc_id = string
 })
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

variable "egress_prefix_list_ids" {
  type    = list(any)
  default = []
}

variable "enable_self" {
  default     = false
  description = "If enabled, allow internal traffic from/to itself (only works with cidr based rules)"
}

variable "tags" {
  type    = map(string)
  default = {}
}
