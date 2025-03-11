module "bootstrap" {
  source = "../../modules/bootstrap"
  tags = { env = "test", management = "terraform" }
}

output "terraform_state_bucket_name" {
  value = module.bootstrap.terraform_state_bucket_domain_name
}

output "terraform_state_lock" {
  value = module.bootstrap.terraform_state_lock_name
}
