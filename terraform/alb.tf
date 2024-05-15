# Classic Load Balancer
resource "aws_elb" "main" {
  name               = "web-elb"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.public_1.id] 

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  cross_zone_load_balancing = true
  idle_timeout              = 400


  tags = {
    Name = "WebCLB"
  }
}

# Target Group Attachment for Instances
resource "aws_elb_attachment" "web" {
  elb      = aws_elb.main.id
  instance = aws_instance.web.id
}