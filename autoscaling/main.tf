# Generate a key pair
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key_pair" {
  key_name   = var.ec2_key_pair
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# Store the private key in Parameter Store
resource "aws_ssm_parameter" "key_pair_private_key" {
  name  = "/ec2/keypair/${var.ec2_key_pair}/private-key"
  type  = "SecureString"
  value = tls_private_key.ec2_key.private_key_pem
}

# Store the key pair name in Parameter Store
resource "aws_ssm_parameter" "key_pair_name" {
  name  = "/ec2/keypair/${var.ec2_key_pair}"
  type  = "SecureString"
  value = aws_key_pair.generated_key_pair.key_name
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role      = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

data "aws_iam_policy_document" "ec2_kms_policy_doc" {
  statement {
    actions   = ["kms:Decrypt"]
    resources = [var.kms_key_arn]
    effect    = "Allow"
  }
}

resource "aws_iam_role_policy" "ec2_kms_policy" {
  name   = "ec2_kms_policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_kms_policy_doc.json
}
resource "aws_iam_role_policy_attachment" "ec2_codedeploy_policy" {
  role      = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# Create a Launch Template
resource "aws_launch_template" "default" {
  name          = "dev-partneraX-api"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.ec2_key_pair



  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  user_data = base64encode(file("./user-data.sh"))  
  network_interfaces {
    security_groups = [var.instance_sg_id]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "default" {
  launch_template {
    id      = aws_launch_template.default.id
    version = "$Latest"
  }

  vpc_zone_identifier  = var.private_subnet_ids_ec2
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  tag {
    key                 = "Name"
    value               = "dev-partneraX-api"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns = var.target_group_arns
}

resource "aws_autoscaling_policy" "partneraX_target_tracking_policy" {
  name                   = "${var.app_name}-target-tracking-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.default.name
  estimated_instance_warmup = 200

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75
  }
}

data "aws_instances" "asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.default.name
  }
}