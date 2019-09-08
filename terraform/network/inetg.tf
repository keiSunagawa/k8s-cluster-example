resource "aws_internet_gateway" "inet_gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "${var.prefix}_gw"
  }
}
