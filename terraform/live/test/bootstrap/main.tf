module "bootstrap" {
  source = "../../modules/bootstrap"
  tags = { env = "test", management = "terraform" }
}