resource "aws_iam_instance_profile" "ec2_profile" {
    name = "session_manager_ec2_profile"
    role = aws_iam_role.session_manager_role.name
}

resource "aws_instance" "web" {
  ami           = "ami-01f10c2d6bce70d90" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  metadata_options {
     http_tokens = "required"
     }
  root_block_device {    # Encryption shold be activated
      encrypted = true
  }
  user_data =  <<-EOF
              #!/bin/bash
              sudo yum install -y docker
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo chown ec2-user /var/run/docker.sock
              sudo docker run -p 80:80 -d nginx
              EOF
  tags = {
    Name = "web-server"
  }
}
