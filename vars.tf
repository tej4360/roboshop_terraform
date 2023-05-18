#variable "env" {}

variable "app_servers" {
  default = {
    frontend = {
      name = "frontend"
      type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      type = "t3.micro"
    }
  }
}

#variable "db_servers" {}
