module "app_servers" {
  for_each = var.app_servers
  source = "./module"
  component_name = each.value["name"]
  env = var.env
  instance_type = each.value["type"]
}