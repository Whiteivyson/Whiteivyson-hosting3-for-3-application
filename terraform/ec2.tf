resource "aws_instance" "web" {
  ami                         = "ami-09b2477d43bc5d0ac"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.pubsub[count.index].id
  key_name                    = "projectkp"
  vpc_security_group_ids      = [aws_security_group.open_tls.id]
  associate_public_ip_address = true
  count                       = 2

  tags = {
    Name = "Webserver"
  }

  # Use provisioner to upload the key from local to the instance
  provisioner "file" {
    source      = "./projectkp.pem"
    destination = "/home/ec2-user/projectkp.pem"
  }

  # Configure SSH connection for the provisioner
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("./projectkp.pem") # Local path to private key
  }
}


#creat private subnet


resource "aws_instance" "db" {
  ami                    = "ami-09b2477d43bc5d0ac"
  instance_type          = "t2.micro"
  key_name               = "projectkp"
  subnet_id              = aws_subnet.prisub.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]


  tags = {
    Name = "DBserver"
  }
}
