output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "instance_sg_id" {
  value = aws_security_group.instance_sg.id
}

output "load_balancer_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}