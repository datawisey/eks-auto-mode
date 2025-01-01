locals {
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  
  # vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  # private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnets

  cluster_version = "1.31"
}