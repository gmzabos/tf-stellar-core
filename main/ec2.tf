### Create security group(s) for the EC2 instance
### allowing SSH only
resource "aws_security_group" "ec2-stellar-core-sg" {
  vpc_id      = aws_vpc.STELLAR-CORE-VPC.id
  name        = "CORE_ec2-stellar-core-sg"
  description = "Allow access Stellar Core node"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.2.0/24"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.default_tags,
    {
      Name = "CORE_ec2-stellar-core-sg"
    }
  )
}
