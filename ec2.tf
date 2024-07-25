# Create Keypair 

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "azhar-public"       # Create a key to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.kp.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
}

#Create EC2 
resource "aws_instance" "azhar-cgp" {
  ami           = "ami-0b72821e2f351e396"  # Replace with your desired AMI ID
  instance_type = "t2.small"               # Replace with your desired instance type
  key_name      = aws_key_pair.kp.id       # Replace with your EC2 key pair name
  subnet_id     = aws_subnet.azhar-cgp-public-subnet1.id  # Replace with your desired subnet ID
  vpc_security_group_ids = [aws_security_group.EC2-public.id]

  associate_public_ip_address = true  # This line ensures automatic assignment of public IP

  tags = {
    Name = "azhar-cgp"
  }
}
