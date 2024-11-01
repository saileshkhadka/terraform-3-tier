# output "db_instance_ids" {
#   description = "The IDs of the RDS cluster instances"
#   value       = [for instance in aws_rds_cluster_instance.default : instance.id]
# }

output "db_cluster_id" {
  description = "The ID of the RDS cluster"
  value       = aws_rds_cluster.default.id
}

# output "db_security_group_id" {
#   value = aws_security_group.default.id
# }

