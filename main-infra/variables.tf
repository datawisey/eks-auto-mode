variable "region" {
  description = "(Required) The AWS Region to create the Terraform State Backend resources in."
  type        = string
  default     = "us-east-1"

}

variable "terraform_stack" {
  description = "The name of the Terraform stack, which should be the name of the repository where the Terraform configuration is stored"
  type        = string
  default     = "deploy-eks-auto-mode-with-terraform"

}

variable "environment" {
  description = "The environment that resources are being deployed to, for example Dev/Prod etc"
  type        = string
  default     = "prod"

}

variable "service" {
  description = "Cluster name"
  type        = string
  default     = "your-cluster"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.31"
}