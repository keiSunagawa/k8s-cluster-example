data "template_file" "userdata" {
  # see https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/create-kubeconfig.html
  template = "${file("${path.module}/userdata.tpl")}"

  vars = {
    endpoint     = "${var.k8s_endpoint}"
    certificate  = "${var.k8s_certificate}"
    cluster_name = "${var.cluster_name}"
  }
}

resource "aws_launch_configuration" "eks_lc" {
  associate_public_ip_address = true
  iam_instance_profile        = "${var.worker_iam_profile_id}"
  image_id                    = "ami-0a67c71d2ab43d36f"
  instance_type               = "${var.instance_type}"
  name_prefix                 = "${var.prefix}_eks_worker"
  key_name                    = "${var.key_name}"
  enable_monitoring           = false
  spot_price                  = var.slot_price

  security_groups  = ["${var.inter_sg_id}", "${var.ssh_sg_id}"]
  user_data_base64 = "${base64encode(data.template_file.userdata.rendered)}"
}

resource "aws_autoscaling_group" "eks_asg" {
  name                 = "${var.prefix}_eks_worker_group"
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.eks_lc.id}"
  max_size             = 2
  min_size             = 2
  target_group_arns    = ["${aws_lb_target_group.worker_lb_tg.arn}"]

  vpc_zone_identifier = keys(var.pud_subnet_items)

  tag {
    key                 = "Name"
    value               = "${var.prefix}_eks_worker"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
