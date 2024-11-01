# loadbalancer/main.tf

# resource "aws_security_group" "default" {
#   name        = "partneraX-lb-sg"
#   description = "Allow inbound traffic for load balancer"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "partneraX-lb-sg"
#   }
# }


data "aws_security_group" "load_balancer" {
  id = var.load_balancer_sg_id
}

resource "aws_lb" "default" {
  name               = "partneraX-lb"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.default.id]
  security_groups    = [data.aws_security_group.load_balancer.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false
  idle_timeout = 60
  drop_invalid_header_fields = true

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.default.arn
  port              = 80
  protocol          = "HTTP"
  depends_on = [ aws_lb_target_group.default ]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.default.arn
#   port              = 443
#   protocol          = "HTTPS"

#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "OK"
#       status_code  = "200"
#     }
#   }
#   #  certificate {
#   #   arn = var.existing_certificate_arn
#   # }
# }

# #Certificate Attachment
# resource "aws_lb_listener_certificate" "cert" {
#   listener_arn    = aws_lb_listener.https.arn
#   certificate_arn = var.certificate_arn
#   # certificate_arn = certificate_arn.cert.arn
# }

# Define the HTTPS listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.default.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  depends_on        = [ aws_lb_target_group.default ]

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

# Attach the SSL certificate to the HTTPS listener
resource "aws_lb_listener_certificate" "cert" {
  listener_arn    = aws_lb_listener.https.arn
  certificate_arn = var.certificate_arn
}


data "aws_instances" "asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = var.asg_name
  }
}

resource "aws_lb_target_group" "default" {
  name        = "partneraX-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 60
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }
}

# resource "aws_lb_target_group_attachment" "default" {
#   count              = length(var.instance_ids)
#   target_group_arn   = aws_lb_target_group.default.arn
#   target_id          = element(var.instance_ids, count.index)
#   port               = 80
# }

# resource "aws_lb_target_group_attachment" "default" {
#   count              = length(data.aws_instances.asg_instances.ids)
#   target_group_arn   = aws_lb_target_group.default.arn
#   target_id          = element(data.aws_instances.asg_instances.ids, count.index)
#   port               = 80
# }