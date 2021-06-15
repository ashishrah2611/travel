resource "aws_lb" "nlb" {
    name               = var.name
    internal           = true
    load_balancer_type = var.nlbType
    subnets            = var.subnets

    enable_deletion_protection = true
    enable_cross_zone_load_balancing = true
//TODO: create bucket for logging, as well as associate policy
#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

    tags = var.tags
}

resource "aws_lb_listener" "https-access" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https_target.arn
  }
}

resource "aws_lb_target_group" "https_target" {
  name     = "${var.name}-https-TG"
  port     = 443
  protocol = "TCP"
  vpc_id   = var.vpcId
}

resource "aws_lb_target_group_attachment" "attach_ec2" {
    count            = length(var.instanceIds)
    target_group_arn = aws_lb_target_group.https_target.arn
    target_id        = var.instanceIds[count.index]
    port             = 443
}
