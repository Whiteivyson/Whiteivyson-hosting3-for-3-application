resource "aws_security_group" "open_tls" {

  vpc_id = aws_vpc.projectvpc.id

  ingress {
    description = "allow tls from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "allow tls from vpc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "open_tls"
  }

}

# SG for MySQL DB
resource "aws_security_group" "allow_tls_db" {
  name        = "allow tls"
  description = "allow tls inbound traffic"
  vpc_id      = aws_vpc.projectvpc.id

  ingress {
    description = "allow tls from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "allow tls from vpc"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls_db"
  }

}

#In our bastion host we install MariaDB 