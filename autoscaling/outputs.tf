output "autoscaling_group_id" {
  value = aws_autoscaling_group.default.id
}

output "instance_ids" {
  value = data.aws_instances.asg_instances.ids
}

output "asg_name" {
  value = aws_autoscaling_group.default.name
}

output "key_pair_private_key" {
  value = aws_ssm_parameter.key_pair_private_key
}