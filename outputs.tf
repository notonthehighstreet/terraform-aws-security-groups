output "sg_id" {
  value = element(concat(aws_security_group.main.*.id, [""]), 0)
}

output "sg_vpc_id" {
  value = element(concat(aws_security_group.main.*.vpc_id, [""]), 0)
}

output "sg_owner_id" {
  value = element(concat(aws_security_group.main.*.owner_id, [""]), 0)
}

output "sg_name" {
  value = element(concat(aws_security_group.main.*.name, [""]), 0)
}

