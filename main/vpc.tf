### Create VPC
resource "aws_vpc" "STELLAR-CORE" {
  cidr_block = "192.168.0.0/22"
  tags = merge(
    var.default_tags,
    {
      Name = "STELLAR-CORE-VPC"
    }
  )
}

### Check available AZs
data "aws_availability_zones" "azs" {
  state = "available"
}

### Create subnets
resource "aws_subnet" "STELLAR-CORE-SUB1" {
  vpc_id            = aws_vpc.STELLAR-CORE-VPC.id
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "192.168.1.0/24"
  tags = merge(
    var.default_tags,
    {
      Name = "STELLAR-CORE-SUB1"
    }
  )
}

resource "aws_subnet" "STELLAR-CORE-SUB2" {
  vpc_id            = aws_vpc.STELLAR-CORE-VPC.id
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "192.168.2.0/24"
  tags = merge(
    var.default_tags,
    {
      Name = "STELLAR-CORE-SUB2"
    }
  )
}

resource "aws_subnet" "STELLAR-CORE-SUB3" {
  vpc_id            = aws_vpc.STELLAR-CORE-VPC.id
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "192.168.3.0/24"
  tags = merge(
    var.default_tags,
    {
      Name = "STELLAR-CORE-SUB3"
    }
  )
}
