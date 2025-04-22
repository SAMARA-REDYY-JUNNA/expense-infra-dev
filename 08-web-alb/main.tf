# resource "aws_alb" "web_alb" {
#   name               = "${var.project_name}-${var.environment}-web-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [data.aws_ssm_parameter.web_alb_sg_id.value]
#   subnets            = split(",", data.aws_ssm_parameter.public_subnet_ids.value)

#   enable_deletion_protection = false

#   tags = merge(
#     var.common_tags,
#     {
#         Name = "${var.project_name}-${var.environment}-web-alb"
#     }
#   )
# }

# resource "aws_alb_listener" "http" {
#   load_balancer_arn = aws_alb.web_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/html"
#       message_body = "<h1>This is fixed response from Web ALB</h1>"
#       status_code  = "200"
#     }
#   }
# }

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_alb.web_alb.arn
#   port              = "443"

#   protocol          = "HTTPS"
#   certificate_arn   = data.aws_ssm_parameter.acm_certificate_arn.value
#   ssl_policy        = "ELBSecurityPolicy-2016-08"

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/html"
#       message_body = "<h1>This is fixed response from Web ALB HTTPS</h1>"
#       status_code  = "200"
#     }
#   }
# }


# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_name = var.zone_name
  
#   records = [
#     {
#       name    = "web-${var.environment}"
#       type    = "A"
#       allow_overwrite = true
#       alias   = {
#         name    = aws_alb.web_alb.dns_name
#         zone_id = aws_alb.web_alb.zone_id
#       }
#     }
#   ]
# }

module "alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = false
  # expense-dev-app-alb
  name    = "${var.project_name}-${var.environment}-web-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.public_subnet_ids
  create_security_group = false
  security_groups = [local.web_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-web-alb"
    }
  )
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.web_alb_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from frontend web ALB with HTTPS</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "web_alb" {
  zone_id = var.zone_id
  name    = "expense-${var.environment}.${var.domain_name}"
  type    = "A"

  # these are ALB DNS name and zone information
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}