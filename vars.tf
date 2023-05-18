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
    cart = {
      name = "cart"
      type = "t3.micro"
    }
    payment = {
      name = "payment"
      type = "t3.micro"
    }
    user = {
      name = "user"
      type = "t3.micro"
    }
    shipping = {
      name = "shipping"
      type = "t3.micro"
    }
  }
}

variable "db_servers" {
  defualt = {
    mangodb = {
      name = "mangodb"
      type = "t3.micro"
    }

    reddis = {
      name = "reddis"
      type = "t3.micro"
    }

    rabbitmq = {
      name = "rabbitmq"
      type = "t3.micro"
    }

    mysql = {
      name = "mysql"
      type = "t3.micro"
    }
  }
}
