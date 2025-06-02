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

## Connecting to the EKS Cluster

### As `devops_user1` (Assuming `devops_role`)

If you are using IAM users and roles as provisioned in this project, and EKS Access Entries for authentication, follow these steps to connect to the EKS cluster as `devops_user1` by assuming the `devops_role`:

1. **Configure AWS CLI for `devops_user1`:**
   ```sh
   aws configure --profile devops_user1
   ```
   Enter the access key and secret for `devops_user1`.

2. **Assume the `devops_role`:**
   ```sh
   aws sts assume-role \
     --role-arn arn:aws:iam::<ACCOUNT_ID>:role/devops_role \
     --role-session-name devops-session \
     --profile devops_user1
   ```
   Replace `<ACCOUNT_ID>` with your AWS account ID.  
   Save the `AccessKeyId`, `SecretAccessKey`, and `SessionToken` from the output.

3. **Export the temporary credentials:**
   ```sh
   set AWS_ACCESS_KEY_ID=<AccessKeyId>
   set AWS_SECRET_ACCESS_KEY=<SecretAccessKey>
   set AWS_SESSION_TOKEN=<SessionToken>
   ```
   *(Use `export` instead of `set` if on Linux/macOS)*

4. **Update kubeconfig for the EKS cluster:**
   ```sh
   aws eks update-kubeconfig \
     --region <region> \
     --name <cluster-name>
   ```
   Replace `<region>` and `<cluster-name>` with your values.

5. **Use kubectl to access the cluster:**
   ```sh
   kubectl get nodes
   kubectl get pods -A
   ```

**Note:**  
This process ensures you are authenticated as `devops_user1` with the permissions of `devops_role` and recognized by EKS via Access Entries.

---

### As the IAM User Used to Deploy Terraform Resources

If you deployed the EKS cluster using an IAM user (for example, your personal or CI/CD user), and this user has administrative or sufficient EKS permissions, you can connect to the cluster directly:

1. **Ensure your AWS CLI is configured for the deployer IAM user:**
   ```sh
   aws configure --profile <deployer-profile>
   ```
   Enter the access key and secret for the deployer IAM user.

2. **Update kubeconfig for the EKS cluster:**
   ```sh
   aws eks update-kubeconfig \
     --region <region> \
     --name <cluster-name> \
     --profile <deployer-profile>
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