# Terraform AWS Infrastructure

This repository contains Terraform configurations for setting up AWS infrastructure including a remote state backend and EKS Auto-Mode cluster.

## Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/) installed and configured
- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- AWS credentials configured (`aws configure`)

## Getting Started

### 1. Clone and Configure

```bash
# Clone the repository
git clone git@github.com:datawisey/eks-auto-mode.git
cd eks-auto-mode

# Verify AWS configuration
aws sts get-caller-identity
```

### 2. Initialize Remote Backend Infrastructure

First, we'll create the S3 bucket and DynamoDB table for Terraform state management.

```bash
# Navigate to backend bootstrap directory
cd backend-bootstrap

# Initialize Terraform
terraform init

# Review the changes
terraform plan

# Apply the configuration
terraform apply

# Note the outputs - you'll need these values for the next step
terraform output
```

### 3. Configure Main Infrastructure

Update the backend configuration in `main-infra/backend.tf` with the outputs from the previous step:

```hcl
terraform {
  backend "s3" {
    bucket         = "<output_bucket_name>"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<output_dynamodb_table>"
    encrypt        = true
  }
}
```

### 4. Deploy Main Infrastructure

```bash
# Navigate to main infrastructure directory
cd ../main-infra

# Initialize Terraform with the new backend
terraform init

# Review the changes
terraform plan

# Apply the configuration
terraform apply
```

### 5. Connect to EKS Cluster (After Deployment)

```bash
# Update kubeconfig
aws eks update-kubeconfig --region us-east-1 --name <cluster-name>

# Verify connection
kubectl get nodes
```

## File Structure

```
.
├── backend-bootstrap/     # Remote state backend configuration
│   └── main.tf           # S3 bucket and DynamoDB table for state
└── main-infra/           # Main infrastructure
    ├── backend.tf        # Backend configuration
    ├── providers.tf      # Provider configurations
    ├── variables.tf      # Variable definitions
    ├── locals.tf         # Local variables
    └── data.tf          # Data sources
```

## Important Notes

- Always review the plan before applying changes
- The backend bootstrap should only be run once
- Keep your AWS credentials secure and never commit them
- Use terraform workspaces for multiple environments

## Cleanup

To destroy the infrastructure (in reverse order):

```bash
# Destroy main infrastructure
cd main-infra
terraform destroy

# Destroy backend infrastructure
cd ../backend-bootstrap
terraform destroy
```


## License

[License details](LICENSE)
