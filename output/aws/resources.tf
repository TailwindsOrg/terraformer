resource "aws_internet_gateway" "tfer--igw-0a2b95465c3d6d3b9" {
  tags = {
    Name  = var.aws_internet_gateway_tfer--igw-0a2b95465c3d6d3b9__tags__Name
    owner = var.aws_internet_gateway_tfer--igw-0a2b95465c3d6d3b9__tags__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_main_route_table_association" "tfer--vpc-06efbe70076b7132d" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-0655477f26ab333c4_id}"
  vpc_id         = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_nat_gateway" "tfer--nat-0798a6e067c56dc2d" {
  allocation_id = var.aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__allocation_id
  subnet_id     = var.aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__subnet_id

  tags = {
    Name  = var.aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__tags__Name
    owner = var.aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__tags__owner
  }
}

resource "aws_route_table" "tfer--rtb-0039773d934a9d0fb" {
  route {
    cidr_block = var.aws_route_table_tfer--rtb-0039773d934a9d0fb__route__cidr_block
    gateway_id = var.aws_route_table_tfer--rtb-0039773d934a9d0fb__route__gateway_id
  }

  tags = {
    Name  = var.aws_route_table_tfer--rtb-0039773d934a9d0fb__tags__Name
    owner = var.aws_route_table_tfer--rtb-0039773d934a9d0fb__tags__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_route_table" "tfer--rtb-01abcdc8f82abb83c" {
  route {
    cidr_block     = var.aws_route_table_tfer--rtb-01abcdc8f82abb83c__route__cidr_block
    nat_gateway_id = var.aws_route_table_tfer--rtb-01abcdc8f82abb83c__route__nat_gateway_id
  }

  tags = {
    Name  = var.aws_route_table_tfer--rtb-01abcdc8f82abb83c__tags__Name
    owner = var.aws_route_table_tfer--rtb-01abcdc8f82abb83c__tags__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_route_table" "tfer--rtb-03133f1dca445ded4" {
  route {
    cidr_block     = var.aws_route_table_tfer--rtb-03133f1dca445ded4__route__cidr_block
    nat_gateway_id = var.aws_route_table_tfer--rtb-03133f1dca445ded4__route__nat_gateway_id
  }

  tags = {
    Name  = var.aws_route_table_tfer--rtb-03133f1dca445ded4__tags__Name
    owner = var.aws_route_table_tfer--rtb-03133f1dca445ded4__tags__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_route_table" "tfer--rtb-0655477f26ab333c4" {
  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_route_table" "tfer--rtb-09b9584e0809872e6" {
  route {
    cidr_block     = var.aws_route_table_tfer--rtb-09b9584e0809872e6__route__cidr_block
    nat_gateway_id = var.aws_route_table_tfer--rtb-09b9584e0809872e6__route__nat_gateway_id
  }

  tags = {
    Name  = var.aws_route_table_tfer--rtb-09b9584e0809872e6__tags__Name
    owner = var.aws_route_table_tfer--rtb-09b9584e0809872e6__tags__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_route_table" "tfer--rtb-0f0d0683821304bee" {
  route {
    cidr_block     = var.aws_route_table_tfer--rtb-0f0d0683821304bee__route__cidr_block
    nat_gateway_id = var.aws_route_table_tfer--rtb-0f0d0683821304bee__route__nat_gateway_id
  }

  tags = {
    Name  = var.aws_route_table_tfer--rtb-0f0d0683821304bee__tags__Name
    owner = var.aws_route_table_tfer--rtb-0f0d0683821304bee__tags__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_subnet" "tfer--subnet-00460a45330bd39cf" {
  assign_ipv6_address_on_creation = var.aws_subnet_tfer--subnet-00460a45330bd39cf__assign_ipv6_address_on_creation
  cidr_block                      = var.aws_subnet_tfer--subnet-00460a45330bd39cf__cidr_block
  map_customer_owned_ip_on_launch = var.aws_subnet_tfer--subnet-00460a45330bd39cf__map_customer_owned_ip_on_launch
  map_public_ip_on_launch         = var.aws_subnet_tfer--subnet-00460a45330bd39cf__map_public_ip_on_launch

  tags = {
    Environment = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags__Environment
    Name        = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags__Name
    Tier        = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags__Tier
    owner       = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags__owner
  }

  tags_all = {
    Environment = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__Environment
    Name        = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__Name
    Tier        = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__Tier
    owner       = var.aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_subnet" "tfer--subnet-00a1807bb2a0bb865" {
  assign_ipv6_address_on_creation = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__assign_ipv6_address_on_creation
  cidr_block                      = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__cidr_block
  map_customer_owned_ip_on_launch = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__map_customer_owned_ip_on_launch
  map_public_ip_on_launch         = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__map_public_ip_on_launch

  tags = {
    Environment = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__Environment
    Name        = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__Name
    Tier        = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__Tier
    owner       = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__owner
  }

  tags_all = {
    Environment = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__Environment
    Name        = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__Name
    Tier        = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__Tier
    owner       = var.aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_subnet" "tfer--subnet-013fd8a9f3d364121" {
  assign_ipv6_address_on_creation = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__assign_ipv6_address_on_creation
  cidr_block                      = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__cidr_block
  map_customer_owned_ip_on_launch = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__map_customer_owned_ip_on_launch
  map_public_ip_on_launch         = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__map_public_ip_on_launch

  tags = {
    Environment = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__Environment
    Name        = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__Name
    Tier        = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__Tier
    owner       = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__owner
  }

  tags_all = {
    Environment = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__Environment
    Name        = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__Name
    Tier        = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__Tier
    owner       = var.aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_subnet" "tfer--subnet-050658f116147cb3b" {
  assign_ipv6_address_on_creation = var.aws_subnet_tfer--subnet-050658f116147cb3b__assign_ipv6_address_on_creation
  cidr_block                      = var.aws_subnet_tfer--subnet-050658f116147cb3b__cidr_block
  map_customer_owned_ip_on_launch = var.aws_subnet_tfer--subnet-050658f116147cb3b__map_customer_owned_ip_on_launch
  map_public_ip_on_launch         = var.aws_subnet_tfer--subnet-050658f116147cb3b__map_public_ip_on_launch

  tags = {
    Environment = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags__Environment
    Name        = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags__Name
    Tier        = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags__Tier
    owner       = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags__owner
  }

  tags_all = {
    Environment = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__Environment
    Name        = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__Name
    Tier        = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__Tier
    owner       = var.aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_subnet" "tfer--subnet-06231713243e1a552" {
  assign_ipv6_address_on_creation = var.aws_subnet_tfer--subnet-06231713243e1a552__assign_ipv6_address_on_creation
  cidr_block                      = var.aws_subnet_tfer--subnet-06231713243e1a552__cidr_block
  map_customer_owned_ip_on_launch = var.aws_subnet_tfer--subnet-06231713243e1a552__map_customer_owned_ip_on_launch
  map_public_ip_on_launch         = var.aws_subnet_tfer--subnet-06231713243e1a552__map_public_ip_on_launch

  tags = {
    Environment = var.aws_subnet_tfer--subnet-06231713243e1a552__tags__Environment
    Name        = var.aws_subnet_tfer--subnet-06231713243e1a552__tags__Name
    Tier        = var.aws_subnet_tfer--subnet-06231713243e1a552__tags__Tier
    owner       = var.aws_subnet_tfer--subnet-06231713243e1a552__tags__owner
  }

  tags_all = {
    Environment = var.aws_subnet_tfer--subnet-06231713243e1a552__tags_all__Environment
    Name        = var.aws_subnet_tfer--subnet-06231713243e1a552__tags_all__Name
    Tier        = var.aws_subnet_tfer--subnet-06231713243e1a552__tags_all__Tier
    owner       = var.aws_subnet_tfer--subnet-06231713243e1a552__tags_all__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_subnet" "tfer--subnet-09c1b977246a943a9" {
  assign_ipv6_address_on_creation = var.aws_subnet_tfer--subnet-09c1b977246a943a9__assign_ipv6_address_on_creation
  cidr_block                      = var.aws_subnet_tfer--subnet-09c1b977246a943a9__cidr_block
  map_customer_owned_ip_on_launch = var.aws_subnet_tfer--subnet-09c1b977246a943a9__map_customer_owned_ip_on_launch
  map_public_ip_on_launch         = var.aws_subnet_tfer--subnet-09c1b977246a943a9__map_public_ip_on_launch

  tags = {
    Environment = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags__Environment
    Name        = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags__Name
    Tier        = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags__Tier
    owner       = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags__owner
  }

  tags_all = {
    Environment = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__Environment
    Name        = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__Name
    Tier        = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__Tier
    owner       = var.aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__owner
  }

  vpc_id = "${data.terraform_remote_state.local.outputs.aws_vpc_tfer--vpc-06efbe70076b7132d_id}"
}

resource "aws_vpc" "tfer--vpc-06efbe70076b7132d" {
  assign_generated_ipv6_cidr_block = var.aws_vpc_tfer--vpc-06efbe70076b7132d__assign_generated_ipv6_cidr_block
  cidr_block                       = var.aws_vpc_tfer--vpc-06efbe70076b7132d__cidr_block
  enable_dns_hostnames             = var.aws_vpc_tfer--vpc-06efbe70076b7132d__enable_dns_hostnames
  enable_dns_support               = var.aws_vpc_tfer--vpc-06efbe70076b7132d__enable_dns_support
  instance_tenancy                 = var.aws_vpc_tfer--vpc-06efbe70076b7132d__instance_tenancy

  tags = {
    Environment = var.aws_vpc_tfer--vpc-06efbe70076b7132d__tags__Environment
    Name        = var.aws_vpc_tfer--vpc-06efbe70076b7132d__tags__Name
    owner       = var.aws_vpc_tfer--vpc-06efbe70076b7132d__tags__owner
  }

  tags_all = {
    Environment = var.aws_vpc_tfer--vpc-06efbe70076b7132d__tags_all__Environment
    Name        = var.aws_vpc_tfer--vpc-06efbe70076b7132d__tags_all__Name
    owner       = var.aws_vpc_tfer--vpc-06efbe70076b7132d__tags_all__owner
  }
}




#MD Generated Variables

variable "aws_internet_gateway_tfer--igw-0a2b95465c3d6d3b9__tags__Name" {
  default = "abinayamdnetwork-igw"
}

variable "aws_internet_gateway_tfer--igw-0a2b95465c3d6d3b9__tags__owner" {
  default = "abinaya"
}

variable "aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__allocation_id" {
  default = "eipalloc-02ae544b0c8e122d2"
}

variable "aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__subnet_id" {
  default = "subnet-013fd8a9f3d364121"
}

variable "aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__tags__Name" {
  default = "abinayamdnetwork-Natgw-1"
}

variable "aws_nat_gateway_tfer--nat-0798a6e067c56dc2d__tags__owner" {
  default = "abinaya"
}

variable "aws_route_table_tfer--rtb-0039773d934a9d0fb__route__cidr_block" {
  default = "0.0.0.0/0"
}

variable "aws_route_table_tfer--rtb-0039773d934a9d0fb__route__gateway_id" {
  default = "igw-0a2b95465c3d6d3b9"
}

variable "aws_route_table_tfer--rtb-0039773d934a9d0fb__tags__Name" {
  default = "abinayamdnetwork-rtb-Public"
}

variable "aws_route_table_tfer--rtb-0039773d934a9d0fb__tags__owner" {
  default = "abinaya"
}

variable "aws_route_table_tfer--rtb-01abcdc8f82abb83c__route__cidr_block" {
  default = "0.0.0.0/0"
}

variable "aws_route_table_tfer--rtb-01abcdc8f82abb83c__route__nat_gateway_id" {
  default = "nat-0798a6e067c56dc2d"
}

variable "aws_route_table_tfer--rtb-01abcdc8f82abb83c__tags__Name" {
  default = "abinayamdnetwork-rtb-private3"
}

variable "aws_route_table_tfer--rtb-01abcdc8f82abb83c__tags__owner" {
  default = "abinaya"
}

variable "aws_route_table_tfer--rtb-03133f1dca445ded4__route__cidr_block" {
  default = "0.0.0.0/0"
}

variable "aws_route_table_tfer--rtb-03133f1dca445ded4__route__nat_gateway_id" {
  default = "nat-0798a6e067c56dc2d"
}

variable "aws_route_table_tfer--rtb-03133f1dca445ded4__tags__Name" {
  default = "abinayamdnetwork-rtb-private2"
}

variable "aws_route_table_tfer--rtb-03133f1dca445ded4__tags__owner" {
  default = "abinaya"
}

variable "aws_route_table_tfer--rtb-09b9584e0809872e6__route__cidr_block" {
  default = "0.0.0.0/0"
}

variable "aws_route_table_tfer--rtb-09b9584e0809872e6__route__nat_gateway_id" {
  default = "nat-0798a6e067c56dc2d"
}

variable "aws_route_table_tfer--rtb-09b9584e0809872e6__tags__Name" {
  default = "abinayamdnetwork-rtb-private4"
}

variable "aws_route_table_tfer--rtb-09b9584e0809872e6__tags__owner" {
  default = "abinaya"
}

variable "aws_route_table_tfer--rtb-0f0d0683821304bee__route__cidr_block" {
  default = "0.0.0.0/0"
}

variable "aws_route_table_tfer--rtb-0f0d0683821304bee__route__nat_gateway_id" {
  default = "nat-0798a6e067c56dc2d"
}

variable "aws_route_table_tfer--rtb-0f0d0683821304bee__tags__Name" {
  default = "abinayamdnetwork-rtb-private1"
}

variable "aws_route_table_tfer--rtb-0f0d0683821304bee__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__assign_ipv6_address_on_creation" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__cidr_block" {
  default = "10.17.96.0/20"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__map_customer_owned_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__map_public_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags__Name" {
  default = "abinayamdnetwork-Subnet-Private4-ap-south-1a"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__Name" {
  default = "abinayamdnetwork-Subnet-Private4-ap-south-1a"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-00460a45330bd39cf__tags_all__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__assign_ipv6_address_on_creation" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__cidr_block" {
  default = "10.17.64.0/20"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__map_customer_owned_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__map_public_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__Name" {
  default = "abinayamdnetwork-Subnet-Private2-ap-south-1b"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__Name" {
  default = "abinayamdnetwork-Subnet-Private2-ap-south-1b"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-00a1807bb2a0bb865__tags_all__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__assign_ipv6_address_on_creation" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__cidr_block" {
  default = "10.17.0.0/24"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__map_customer_owned_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__map_public_ip_on_launch" {
  default = "true"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__Name" {
  default = "abinayamdnetwork-Subnet-Public1-ap-south-1a"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__Tier" {
  default = "public"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__Name" {
  default = "abinayamdnetwork-Subnet-Public1-ap-south-1a"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__Tier" {
  default = "public"
}

variable "aws_subnet_tfer--subnet-013fd8a9f3d364121__tags_all__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__assign_ipv6_address_on_creation" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__cidr_block" {
  default = "10.17.2.0/24"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__map_customer_owned_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__map_public_ip_on_launch" {
  default = "true"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags__Name" {
  default = "abinayamdnetwork-Subnet-Public2-ap-south-1b"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags__Tier" {
  default = "public"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__Name" {
  default = "abinayamdnetwork-Subnet-Public2-ap-south-1b"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__Tier" {
  default = "public"
}

variable "aws_subnet_tfer--subnet-050658f116147cb3b__tags_all__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__assign_ipv6_address_on_creation" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__cidr_block" {
  default = "10.17.48.0/20"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__map_customer_owned_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__map_public_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags__Name" {
  default = "abinayamdnetwork-Subnet-Private1-ap-south-1a"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags_all__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags_all__Name" {
  default = "abinayamdnetwork-Subnet-Private1-ap-south-1a"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags_all__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-06231713243e1a552__tags_all__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__assign_ipv6_address_on_creation" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__cidr_block" {
  default = "10.17.80.0/20"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__map_customer_owned_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__map_public_ip_on_launch" {
  default = "false"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags__Name" {
  default = "abinayamdnetwork-Subnet-Private3-ap-south-1c"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags__owner" {
  default = "abinaya"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__Environment" {
  default = "production"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__Name" {
  default = "abinayamdnetwork-Subnet-Private3-ap-south-1c"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__Tier" {
  default = "private"
}

variable "aws_subnet_tfer--subnet-09c1b977246a943a9__tags_all__owner" {
  default = "abinaya"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__assign_generated_ipv6_cidr_block" {
  default = "false"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__cidr_block" {
  default = "10.17.0.0/16"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__enable_dns_hostnames" {
  default = "true"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__enable_dns_support" {
  default = "true"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__instance_tenancy" {
  default = "default"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__tags__Environment" {
  default = "production"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__tags__Name" {
  default = "abinayamdnetwork"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__tags__owner" {
  default = "abinaya"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__tags_all__Environment" {
  default = "production"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__tags_all__Name" {
  default = "abinayamdnetwork"
}

variable "aws_vpc_tfer--vpc-06efbe70076b7132d__tags_all__owner" {
  default = "abinaya"
}

