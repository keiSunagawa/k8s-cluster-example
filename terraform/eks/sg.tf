resource "aws_security_group" "eks_master_pub_api_sg" {
  name        = "${var.prefix}_eks_master_pub_api"
  description = "k8 API allowed access from public network."

  tags = {
    Name = "${var.prefix}_eks_master_pub_api"
  }

  vpc_id = "${var.main_vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
