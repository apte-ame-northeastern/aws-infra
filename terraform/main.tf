locals {
  vpc_cidrs = [for number in range(0, "${var.vpc_count}") : cidrsubnet("${var.cidr}", 8, number)]
}

module "myNetwork" {
  count  = var.vpc_count
  source = "./module/networking"
  cidr   = local.vpc_cidrs[count.index]
  # cidr = "${var.cidr}"
  vpc_count      = var.vpc_count
  priv_sub_count = var.priv_sub_count
  pub_sub_count  = var.pub_sub_count
  region         = var.region
  environment    = var.environment


  ingress_cidr            = var.ingress_cidr
  public_key_loc          = var.public_key_loc
  my_ami_id               = var.my_ami_id
  instance_type           = var.instance_type
  delete_on_termination   = var.delete_on_termination
  volume_size             = var.volume_size
  volume_type             = var.volume_type
  disable_api_termination = var.disable_api_termination
  app_port                = var.app_port

}

