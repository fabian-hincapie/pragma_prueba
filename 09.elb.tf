resource "aws_lb" "lb" {
  name               = "Elb-${var.project}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ELB.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  enable_deletion_protection = false

  tags = {
    Name        = "Elb-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "tg-front" {
  name        = "tg-front"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name        = "tg-front-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-front.arn
  }
}