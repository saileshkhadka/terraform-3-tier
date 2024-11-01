# loadbalancer/outputs.tf

output "load_balancer_arn" {
  value = aws_lb.default.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.default.arn
}

# output "load_balancer_sg_id" {
#   value = module.securitygroups.load_balancer_sg_id
# }