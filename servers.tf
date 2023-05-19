module "app_servers" {
  depends_on = ["db_servers"]
  for_each = var.app_servers
  source = "./common"
  instance_type = each.value["type"]
  component_name = each.value["name"]
}

module "db_servers" {
  for_each = var.db_servers
  source = "./common"
  instance_type = each.value["type"]
  component_name = each.value["name"]
}