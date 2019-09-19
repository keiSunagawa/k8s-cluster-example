resource "aws_lb" "worker_lb" {
  name               = "${var.prefix}-worker-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.inter_sg_id}", "${aws_security_group.http_sg.id}"]
  subnets            = keys(var.pud_subnet_items)
}

resource "aws_lb_target_group" "worker_lb_tg" {
  name     = "${var.prefix}-worker-tg"
  port     = 30080
  protocol = "HTTP"
  vpc_id   = "${var.main_vpc_id}"
}

resource "aws_lb_target_group" "worker_lb_api_tg" {
  name     = "${var.prefix}-worker-api-tg"
  port     = 30090
  protocol = "HTTP"
  vpc_id   = "${var.main_vpc_id}"
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 30
    path                = "/status"
  }
}

resource "aws_lb_target_group" "worker_lb_gql_tg" {
  name     = "${var.prefix}-worker-gql-tg"
  port     = 30100
  protocol = "HTTP"
  vpc_id   = "${var.main_vpc_id}"
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 30
    path                = "/status"
  }

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

resource "aws_lb_listener" "web_api_http" {
  load_balancer_arn = "${aws_lb.worker_lb.arn}"
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.worker_lb_api_tg.arn}"
  }
}

resource "aws_lb_listener" "web_gql_http" {
  load_balancer_arn = "${aws_lb.worker_lb.arn}"
  port              = "8081"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.worker_lb_gql_tg.arn}"
  }
}
