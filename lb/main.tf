resource "aws_lb" "app-lb" {
  name = "app-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = var.security_groups
  subnets = var.subnet
  enable_deletion_protection = false
  idle_timeout = 3600
  enable_cross_zone_load_balancing = true
}
resource "aws_lb_target_group" "target-group" {
  name = "target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app-lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "fixed-response"
    #type = "fixed-responce"
    fixed_response {
      status_code = "200"
      content_type = "text/plain"
      message_body = "hello from ALB"
    }
  }
}
resource "aws_lb_target_group_attachment" "wed_server" {

  target_group_arn = aws_lb_target_group.target-group.arn
  target_id = var.ec2_instance_id
  port =80

}
