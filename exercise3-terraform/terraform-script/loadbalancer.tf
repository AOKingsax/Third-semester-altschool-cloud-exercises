# aws_lb

resource "aws_lb" "my-lb" {
  name               = "my-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.public_subnet3.id]

  enable_deletion_protection = false

  tags = local.common_tags
}

# aws_lb_target_group

resource "aws_lb_target_group" "my-lb-tg" {
  name     = "my-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myVPC.id
  tags     = local.common_tags
}

# aws_lb_target_group_attachment

resource "aws_lb_target_group_attachment" "my-lb-tg1" {
  target_group_arn = aws_lb_target_group.my-lb-tg.arn
  target_id        = aws_instance.webserver.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "my-lb-tg2" {
  target_group_arn = aws_lb_target_group.my-lb-tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "my-lb-tg3" {
  target_group_arn = aws_lb_target_group.my-lb-tg.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}


# aws_lb_listerner_group

resource "aws_lb_listener" "alb-website" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-lb-tg.arn
  }

  tags = local.common_tags
}