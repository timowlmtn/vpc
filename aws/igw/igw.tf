
##########################
## Nat gateway
resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_nat_gateway" "owlmtn_nat" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id = "${aws_subnet.owlmtn_public_subnet[1].id}"
  depends_on = ["aws_internet_gateway.owlmtn_igw"]
  tags = {
    Name = "owlmtn-public-nat"
  }
}

resource "aws_route_table_association" "public" {
  count = "${length(var.private_subnet_cidr)}"

  subnet_id      = "${element(aws_subnet.owlmtn_private_lambda_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.owlmtn_lambda_route_table.id}"
}

# Create the Internet Access for Private Lambda
resource "aws_route" "owlmtn_internet_access" {
  route_table_id        = "${aws_route_table.owlmtn_lambda_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  nat_gateway_id = "${aws_nat_gateway.owlmtn_nat.id}"
} # end resource