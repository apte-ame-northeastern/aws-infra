# AWS-Infra

Created a terraform file structure to provision resources on AWS. These resources include provisioning of VPC, public / private subnets, internet gateway, and route table.

## AWS CLI Setup and creating Terraform files

**1.** Downloaded the AWS CLI.

**2.** Generated Access Key for dev / demo IAM user and hence configure these credentials using aws configure.

**3.** Installed Terraform and created the required files to provision the required AWS resources.

**4.** Created module in terraform and also used '.tfvars' file to pass run-time user arguments as inputs  

## Created following AWS resources -

**a.** A VPC

**b.** 3 public subnets with each subnet in a different availability zone but in the same region and in the same VPC.

**c.** 3 private subnets with each subnet in a different availability zone but in the same region and in the same VPC.

**d.** An Internet Gateway and attached it to the VPC created above.

**e.** A public route table and attached it to all public subnets.

**f.** A private route table and attached it to all private subnets.

**g.** A public route in public route table with the destination CIDR block as `0.0.0.0/0` and the internet gateway created above as the target.
## Important terraform commands

**1.** terraform fmt

**2.** terraform init

**3.** terraform plan -var-file="fileName.tfvars"

**4.** terraform apply

**5.** terraform destroy

## Other important commands

**1.** mv oldFileName newFileName

**2.** cp ../../fileName .

**3.** cd ../../