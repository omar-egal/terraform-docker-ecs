terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

# provider "docker" {}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
