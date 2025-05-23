resource "aws_alb" "app_alb" {
    name               = "${var.project_name}-${var.environment}-app-alb"
    internal           = true
    load_balancer_type = "application"
    # vpc_id = data.aws_ssm_parameter.vpc_id.value
    security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
    subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    enable_deletion_protection = false

    tags = merge(
        var.common_tags,
        {
            Name        = "${var.project_name}-${var.environment}-app-alb"
        }    
    )
}

resource "aws_alb_listener" "http" {
    load_balancer_arn = aws_alb.app_alb.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
        type = "fixed-response"
        
        fixed_response {
            content_type = "text/html"
            message_body = "<h1>this is fixed response from app alb</h1>"
            status_code  = "200"
        }
    } 
}
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = var.zone_name
  
  records = [
    {
      name    = "*.app-${var.environment}"
      type    = "A"
      allow_overwrite = true
      alias   = {
        name    = aws_alb.app_alb.dns_name
        zone_id = aws_alb.app_alb.zone_id
      }
    }
  ]
}
    
    
