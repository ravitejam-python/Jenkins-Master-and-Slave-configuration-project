provider "aws" {
    region = "us-east-1"    #set ur desired region
}

#Security Group used by Jenkins Master
resource "aws_security_group" "mysg" {
  name   = "jenkins-master-sg"

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   ingress {                     
    description      = "Jenkins Port 8080 for Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#Security Group used by Jenkins Slave agent
resource "aws_security_group" "mysg2" {
  name   = "jenkins-slave-sg"

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "Jenkins-Master-Server" {
    ami = "ami-0c7217cdde317cfec"    # AWS Ubuntu instance AMI ID
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.mysg.id]
    user_data = base64encode(file("userdata.sh"))
  
}

resource "aws_instance" "Jenkins-Slave-Server" {
    ami = "ami-0c7217cdde317cfec"    # AWS Ubuntu instance AMI ID
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.mysg2.id]
    user_data = base64encode(file("userdata1.sh"))
  
}