resource "aws_vpc" "main_vpc" {
  cidr_block = "172.30.0.0/16"
  tags = {
    Name = "${var.prefix}_vpc"
  }
}
