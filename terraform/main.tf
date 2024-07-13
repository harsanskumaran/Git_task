terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  access_key =var.AWS_Access_Key[0]
  secret_key =var.AWS_Access_Key[1]
default_tags {
        tags = {
    Name = "Guvi_Task"
    env = "Demo"
}
}
}
resource "aws_instance" "App_Server"{
  ami ="ami-01376101673c89611"
  instance_type ="t2.micro"
  security_groups = [aws_security_group.App_security_group.name]
   user_data =file("script.sh")
}

resource "aws_security_group" "App_security_group" {
name = "App_security_group_SG"
vpc_id = "vpc-07fe44633d1d15023"

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks	= ["0.0.0.0/0"]
}

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks	= ["0.0.0.0/0"]

}
}
resource "aws_lb" "App_load_balancer" {
  name = "App-load-balancer-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.App_security_group.id]
  subnets            = var.AWS_Subnet_Lb
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "App_Target_group" {
  name        = "App-Target-group-TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id = "vpc-07fe44633d1d15023"
}

resource "aws_lb_listener" "App_Listener_LB" {
  load_balancer_arn = aws_lb.App_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.App_Target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "g_attachment" {
  target_group_arn = "${aws_lb_target_group.App_Target_group.arn}"
  target_id        = "${aws_instance.App_Server.id}"
  port             = 80
}

#--------------------------2nd region ec2 instance--------------------------------------------------

provider "aws" {
alias = "App_2_Region"
  region  = "us-east-1"
  access_key =var.AWS_Access_Key[0]
  secret_key =var.AWS_Access_Key[1]
default_tags {
        tags = {
    Name = "Guvi_Task_2"
    env = "Demo"
}
}
}		

resource "aws_instance" "DR_2_App_Server"{
provider =aws.App_2_Region
  ami ="ami-0b72821e2f351e396"
  instance_type ="t2.micro"
   user_data =file("script.sh")
}
			
														
