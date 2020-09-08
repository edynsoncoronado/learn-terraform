provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
}

resource "aws_security_group" "allow_conda" {
  name        = "allow_conda_traffic"
  description = "Allow Conda inbound traffic"

  ingress {
    description = "HTTPS"
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_conda"
  }
}

resource "aws_instance" "conda-instance" {
  ami               = "ami-06b263d6ceff0b3dd"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "mrrobot"
  vpc_security_group_ids = [aws_security_group.allow_conda.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install python3-pip curl zip -y

              wget -qO- https://get.docker.com/ | sh
              sudo usermod -aG docker ubuntu
              sudo systemctl enable docker
              sleep 5
              pip3 install docker-compose

              sudo mkdir /opt/project && cd /opt/project
              sudo chown ubuntu:ubuntu /opt/project/
              echo "local_volum=/opt/project" > .env

              curl https://d2l.ai/d2l-en.zip -o d2l-en.zip
              unzip d2l-en.zip 
              rm d2l-en.zip

              git clone https://github.com/edynsoncoronado/learn-docker.git
              docker-compose -f learn-docker/images-docker/miniconda-mxnet/conda-compose.yml up
              sudo rm -r learn-docker/

              EOF
  tags = {
    Name = "conda-server"
  }
}