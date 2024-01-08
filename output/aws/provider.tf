provider "aws" {
  region = "ap-south-1"
}

terraform {
	required_providers {
		aws = {
	    version = "~> 3.33.0"
		}
  }
}
