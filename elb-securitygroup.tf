# Resource-1: Create Security For elb
resource "aws_security_group" "elb-public" {
  name        = "elb-public"
  description = "elb public Security Group"
  vpc_id      =   aws_vpc.main.id
  

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
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
    Name = "elb-public"
  }
}