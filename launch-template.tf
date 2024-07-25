resource "aws_launch_template" "azhar-lt" {
  name = "azhar-lt"

  image_id      = "ami-010fa57654d59f417"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.kp.id

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.lt-sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "azhar-lt"
    }
  }
}
