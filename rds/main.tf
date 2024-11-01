resource "aws_secretsmanager_secret" "db_credentials" {
  name = var.secret_name

  tags = {
    Name =var.secret_name
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    password = var.db_master_password
  })
}

data "aws_secretsmanager_secret" "db_credentials" {
  name = aws_secretsmanager_secret.db_credentials.name
}

data "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)
}


resource "aws_db_subnet_group" "default" {
  name        = "${var.db_name}-subnet-group"
  subnet_ids  = var.private_subnet_ids
  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

resource "aws_iam_role" "monitoring_role" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_rds_cluster" "default" {
  cluster_identifier   = "${var.db_name}-cluster"
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.db_sg_id]
  database_name        = var.db_name
  master_username      = var.db_master_username
  master_password      = local.db_credentials["password"]
  engine               = "aurora-mysql"
  engine_version       = "8.0.mysql_aurora.3.05.2"
  skip_final_snapshot  = true
  allow_major_version_upgrade = true
  db_cluster_parameter_group_name = "default.aurora-mysql8.0"
  backup_retention_period  = 5
  engine_mode         = "provisioned"

  serverlessv2_scaling_configuration {
    max_capacity = 10
    min_capacity = 2
  }

  tags = {
    Name = "${var.db_name}-cluster"
  }
  depends_on = [
    aws_secretsmanager_secret.db_credentials,
    aws_secretsmanager_secret_version.db_credentials_version
  ]
}

resource "aws_rds_cluster_instance" "default" {
  # count              = var.db_cluster_count
  # identifier         = "${var.db_name}-instance-${count.index + 1}"
  identifier         = "${var.db_name}-serverless"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.db_cluster_instance_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  monitoring_role_arn = aws_iam_role.monitoring_role.arn
  monitoring_interval = 60

  tags = {
    # Name = "${var.db_name}-instance-${count.index + 1}"
    Name  = "${var.db_name}-serverless"
  }
}


resource "aws_iam_role_policy_attachment" "monitoring_policy_attachment" {
  role       = aws_iam_role.monitoring_role.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
