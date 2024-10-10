resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.projectvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public_rt"
  }

}


#Association subnets to rt 
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.pubsub[count.index].id
  route_table_id = aws_route_table.publicrt.id
  count          = 2
}

#association NAT to prirt to use a bastion host and install sql in private server
resource "aws_default_route_table" "prirtb" {
  default_route_table_id = aws_vpc.projectvpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }


  tags = {
    Name = "defaultrtb"
  }
}