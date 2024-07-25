# Resource-1: Create Security For ec2
resource "aws_security_group" "EC2-public" {
  name        = "EC2-public"
  description = "ec2 public Security Group"
  vpc_id      =   aws_vpc.main.id

  ingress {
    description = "Allow Port 3389"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Ec2-public"
  }
}