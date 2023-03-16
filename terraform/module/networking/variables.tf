variable "cidr" {
  type        = string
  description = "CIDR for the VPC"
  //default     = "10.0.0.0/8"
}

variable "vpc_count" {
  type        = string
  description = "Count of the total number of VPCs"
  //default     = "2"
}

variable "priv_sub_count" {
  type        = string
  description = "Count of the total number of private subnets"
  //default     = "3"
}

variable "pub_sub_count" {
  type        = string
  description = "Count of the total number of public subnets"
  //default     = "3"
}

variable "region" {
  type        = string
  description = "Region for the VPC, subnets, gateway, route tables, etc."
  //default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment of deployment"
  //default     = "dev"
}



variable "ingress_cidr" {
  type        = string
  description = "CIDR for ingress"
  default     = "0.0.0.0/0"
}

variable "public_key_loc" {
  type        = string
  description = "Location of public key"
  default     = "C:\\Users\\AMEYA A\\.ssh\\ec2.pub"
}

variable "my_ami_id" {
  type        = string
  description = "Enter your custom AMI ID"
}

variable "instance_type" {
  type        = string
  description = "Enter Instance Type"
  default     = "t2.micro"
}

variable "delete_on_termination" {
  type    = bool
  default = true
}

variable "volume_size" {
  type    = number
  default = 50
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "my_domain_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type = string
}

variable "ttl" {
  type = number
}

data "aws_availability_zones" "azs" {}
