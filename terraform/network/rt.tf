resource "aws_route_table" "pub_rt" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.inet_gw.id}"
  }

  tags = {
    Name = "${var.prefix}_rt"
  }
}
