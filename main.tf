module "network" {
  source = "./modules/network"

  environment             = var.environment
  project_name            = var.project_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_one_cidr  = var.public_subnet_one_cidr
  public_subnet_two_cidr  = var.public_subnet_two_cidr
  private_subnet_one_cidr = var.private_subnet_one_cidr
  private_subnet_two_cidr = var.private_subnet_two_cidr
  availability_zone_one   = var.availability_zone_one
  availability_zone_two   = var.availability_zone_two
}

module "compute" {
  source = "./modules/compute"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_one_id
}

module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
  environment  = var.environment
}

module "database" {
  source = "./modules/database"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_subnet_ids
  web_security_group_id = module.compute.web_security_group_id
  db_username           = var.db_username
  db_password           = var.db_password
}
