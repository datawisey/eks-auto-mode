data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
# data "terraform_remote_state" "network" {
#   backend = "s3"
#   config = {
#     bucket  = "your-terraform-state-bucket"
#     key     = "terraform/state.tfstate"
#     region  = "us-east-1"
#     profile = "default"
#   }
# }
