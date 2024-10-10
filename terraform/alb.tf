# Creating ALB 
resource "aws_lb" "proalb" {
  name               = "pro-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.open_tls.id]
  subnets            = [for subnet in aws_subnet.pubsub : subnet.id] # we are using for to iriterate btw 2 pub sub

  enable_deletion_protection = true


  tags = {
    Environment = "project"
  }
}

#create targets for our alb
resource "aws_lb_target_group" "protg" {
  name     = "pro-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.projectvpc.id


   # Health check configuration
  health_check {
    interval            = 10                        # Interval between health checks in seconds
    path                = "/"                 # Path for health check
    port                = "80"            # Can also specify port like "80" or leave as traffic-port
    healthy_threshold   = 3                         # Number of consecutive successes before considered healthy
    unhealthy_threshold = 10                        # Number of consecutive failures before considered unhealthy
    timeout             = 5                         # Time to wait for a response (in seconds)
  }
}

resource "aws_lb_target_group_attachment" "front_end" {
  target_group_arn = aws_lb_target_group.protg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
  count = 2
}

#ALB Listener


resource "aws_lb_listener" "albl" {
  load_balancer_arn = aws_lb.proalb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.protg.arn
  }
}

#We ssh into public instances, install and start httpd to allow instance to pass health checks 