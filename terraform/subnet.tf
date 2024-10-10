resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = var.cidr[count.index]
  count = 2

  tags = {
    Name = "Public subnet"
  }
}

resource "aws_subnet" "prisub" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "Private subnet"
  }
}

data "aws_subnets" "sid" {
  filter {
    name = "vpc-id"
    values = [aws_vpc.projectvpc.id]
  }
}