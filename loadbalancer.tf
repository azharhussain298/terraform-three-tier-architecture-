resource "aws_lb" "azhar-alb" {
  name               = "azhar-alb"
  internal           = false  # Set to true for internal ALB, false for internet-facing
  load_balancer_type = "application"

  security_groups = [aws_security_group.elb-public.id]
  subnets         = [
    aws_subnet.azhar-cgp-public-subnet1.id,
    aws_subnet.azhar-cgp-public-subnet2.id,
     # Replace with your subnet IDs
  ]

  tags = {
    Name = "azhar-alb"
  }
}
resource "aws_lb_listener" "azhar" {
  load_balancer_arn = aws_lb.azhar-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.azhar-tg.arn
  }
}


