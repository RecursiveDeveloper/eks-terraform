# EKS Terraform Architecture

This project provides a modular Terraform configuration to provision an AWS EKS (Elastic Kubernetes Service) cluster, including VPC networking and IAM resources.

## Project Architecture
![image](https://raw.githubusercontent.com/RecursiveDeveloper/static-media-content/refs/heads/main/HA_Eks_Terraform-Diagram.jpg)

## Project Structure

```
eks-terraform/
├── main.tf
├── variables.tf
├── terraform.auto.tfvars
├── README.md
├── modules/
│   ├── ecr/
│   │   ├── main.tf
│   │   └── variables.tf
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
- **ECR Module:** Creates container repositories for backend and frontend applications.
- **EKS Module:** Deploys an EKS cluster with managed node groups.

## Prerequisites

Before deploying this Terraform configuration, ensure you have the following prerequisites in place:

### 1. S3 Backend Bucket

Create an S3 bucket named `tfm-unir-backend` in the `us-east-1` region to store the Terraform state file. This bucket is referenced in the [provider.tf](provider.tf) configuration.

```sh
aws s3 mb s3://tfm-unir-backend --region us-east-1
```

### 2. Environment Configuration Files

Create the following directory structure and environment files in your S3 bucket:

```
tfm-unir-backend/
├── backend/
│   └── .env.docker
└── frontend/
    └── .env.docker
```

Each `.env.docker` file should contain the necessary environment variables for your backend and frontend applications respectively.

**Example backend/.env.docker:**
```
DATABASE_URL=your_database_url
API_KEY=your_api_key
ENVIRONMENT=production
```

**Example frontend/.env.docker:**
```
REACT_APP_API_URL=your_api_url
REACT_APP_ENV=production
```

## Usage

### Local Deployment

1. **Clone the repository:**

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

### GitHub Actions Deployment

For automated deployment using GitHub Actions, ensure the following repository secrets are configured:

- `AWS_ACCESS_KEY_ID`: Your AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key

These secrets will be used by the GitHub Actions workflow to authenticate with AWS and deploy the infrastructure.

## Connecting to the EKS Cluster

### As the IAM User Used to Deploy Terraform Resources

If you deployed the EKS cluster using an IAM user (for example, your personal or CI/CD user), and this user has administrative or sufficient EKS permissions, you can connect to the cluster directly:

1. **Ensure your AWS CLI is configured for the deployer IAM user:**
   ```sh
   aws configure --profile <deployer-profile>
   ```
   Enter the access key and secret for the deployer IAM user.

2. **Update kubeconfig for the EKS cluster:**
   ```sh
   aws eks update-kubeconfig --region <region> --name <cluster-name> --profile <deployer-profile>
   ```
   Replace `<region>`, `<cluster-name>`, and `<deployer-profile>` with your values.

3. **Use kubectl to access the cluster:**
   ```sh
   kubectl get nodes
   kubectl get pods -A
   ```

**Note:**  
The deployer IAM user is typically granted full access to the EKS cluster during creation and is automatically recognized by EKS for cluster administration.

---

If you use a different IAM user or role, repeat the process with the appropriate credentials.

## Modules

- [`modules/vpc`](modules/vpc/main.tf): Provisions the VPC and networking resources.
- [`modules/iam`](modules/iam/main.tf): Manages IAM users, groups, and policies.
- [`modules/ecr`](modules/ecr/main.tf): Creates ECR repositories for container images.
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
