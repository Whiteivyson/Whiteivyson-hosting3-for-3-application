resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.projectvpc.id

  tags = {
    Name = "proigw"
  }
}