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
  ttl                     = var.ttl
  my_domain_name          = var.my_domain_name
  db_name                 = var.db_name
  db_password             = var.db_password
  db_username             = var.db_username

  asg_min_size                                 = var.asg_min_size
  asg_max_size                                 = var.asg_max_size
  asg_desired_capacity                         = var.asg_desired_capacity
  asg_default_cooldown                         = var.asg_default_cooldown
  scale_up_policy_cooldown                     = var.scale_up_policy_cooldown
  scale_up_policy_scaling_adjustment           = var.scale_up_policy_scaling_adjustment
  scale_down_policy_cooldown                   = var.scale_down_policy_cooldown
  scale_down_policy_scaling_adjustment         = var.scale_down_policy_scaling_adjustment
  cw_metric_alarm_scaleup_evaluation_periods   = var.cw_metric_alarm_scaleup_evaluation_periods
  cw_metric_alarm_scaleup_period               = var.cw_metric_alarm_scaleup_period
  cw_metric_alarm_scaleup_threshold            = var.cw_metric_alarm_scaleup_threshold
  cw_metric_alarm_scaledown_evaluation_periods = var.cw_metric_alarm_scaledown_evaluation_periods
  cw_metric_alarm_scaledown_period             = var.cw_metric_alarm_scaledown_period
  cw_metric_alarm_scaledown_threshold          = var.cw_metric_alarm_scaledown_threshold
  health_check_healthy_threshold               = var.health_check_healthy_threshold
  health_check_unhealthy_threshold             = var.health_check_unhealthy_threshold
  health_check_timeout                         = var.health_check_timeout
  health_check_interval                        = var.health_check_interval

}

