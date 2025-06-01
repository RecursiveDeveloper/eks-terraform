# EKS Terraform Architecture

This project provides a modular Terraform configuration to provision an AWS EKS (Elastic Kubernetes Service) cluster, including VPC networking and IAM resources.

## Project Architecture
![image](https://raw.githubusercontent.com/RecursiveDeveloper/static-media-content/refs/heads/main/eks-terraform-architecture.jpg)

## Project Structure

```
eks-terraform/
├── main.tf
├── variables.tf
├── terraform.auto.tfvars
├── README.md
├── modules/
│   ├── eks/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── iam/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
```

## Features

- **VPC Module:** Provisions a VPC with public and private subnets across multiple AZs.
- **IAM Module:** Creates IAM users, groups, and policies for DevOps access.
- **EKS Module:** Deploys an EKS cluster with managed node groups.

## Usage

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd eks-terraform
   ```

2. **Configure your AWS credentials:**
   Ensure your AWS credentials are set in your environment or via the AWS CLI.

3. **Review and update variables:**
   Edit `terraform.auto.tfvars` to match your desired configuration (VPC CIDR, subnets, cluster name, etc).

4. **Initialize Terraform:**
   ```sh
   terraform init
   ```

5. **Plan the deployment:**
   ```sh
   terraform plan
   ```

6. **Apply the configuration:**
   ```sh
   terraform apply
   ```

## Modules

- [`modules/vpc`](modules/vpc/main.tf): Provisions the VPC and networking resources.
- [`modules/iam`](modules/iam/main.tf): Manages IAM users, groups, and policies.
- [`modules/eks`](modules/eks/main.tf): Deploys the EKS cluster and node groups.

## Requirements

- Terraform >= 1.0
- AWS CLI configured
- AWS account with permissions to create EKS, VPC, and IAM resources

## Customization

Edit [`terraform.auto.tfvars`](terraform.auto.tfvars) to set:
- VPC name, CIDR, subnets, and AZs
- EKS cluster name and node group configuration

## Notes

- The VPC and EKS modules use the official [terraform-aws-modules](https://github.com/terraform-aws-modules) for best practices.
- IAM resources are created for demonstration and should be customized for production use.

## License

MIT
