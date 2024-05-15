resource "aws_iam_instance_profile" "ec2_profile" {
    name = "session_manager_ec2_profile"
    role = aws_iam_role.session_manager_role.name
}

resource "aws_instance" "web" {
  ami           = "ami-01f10c2d6bce70d90" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_1.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  depends_on = [aws_nat_gateway.nat]

  user_data = <<-EOF
            #!/bin/bash

            echo "running install script" >> /tmp/install.log

            # Wait for internet connectivity using ping to 1.1.1.1 before proceeding
            while ! ping -c 1 1.1.1.1 &> /dev/null; do
              echo 'Waiting for internet connection...'
              sleep 5
            done

            # Update system packages
            sudo yum update -y

            # Install Docker
            sudo yum install -y docker

            # Start and enable Docker
            sudo systemctl start docker
            sudo systemctl enable docker

            # Add ec2-user to the docker group
            sudo usermod -aG docker ec2-user

            # Pull and run Nginx Docker container
            sudo docker run -p 80:80 -d nginx

            echo "finished running install script" >> /tmp/install.log
            EOF
  tags = {
    Name = "web-server"
  }
}
