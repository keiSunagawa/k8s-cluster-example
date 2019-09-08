resource "aws_lb" "worker_lb" {
  name               = "${var.prefix}-worker-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.inter_sg_id}"]
  subnets            = keys(var.pud_subnet_items)
}

resource "aws_lb_target_group" "worker_lb_tg" {
  name     = "${var.prefix}-worker-tg"
  port     = 30080
  protocol = "HTTP"
  vpc_id   = "${var.main_vpc_id}"
}

resource "aws_lb_listener" "web_console_http" {
  load_balancer_arn = "${aws_lb.worker_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.worker_lb_tg.arn}"
  }
}
