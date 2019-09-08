locals {
  sub_params = [
    { az = "ap-northeast-1a", cidr = "172.30.1.0/24" },
    { az = "ap-northeast-1c", cidr = "172.30.2.0/24" }
  ]
}
resource "aws_subnet" "pub_subns" {
  count             = "${length(local.sub_params)}"
  vpc_id            = "${aws_vpc.main_vpc.id}"
  cidr_block        = "${local.sub_params[count.index].cidr}"
  availability_zone = "${local.sub_params[count.index].az}"

  tags = {
    Name = "${var.prefix}_pub_subnet_${local.sub_params[count.index].az}"
  }
}

resource "aws_route_table_association" "pub_ascs" {
  count          = "${length(local.sub_params)}"
  subnet_id      = "${aws_subnet.pub_subns[count.index].id}"
  route_table_id = "${aws_route_table.pub_rt.id}"
}
