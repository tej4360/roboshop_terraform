env ="dev"

app_servers = {
  frontend = {
    name = "frontend"
    type = "t3.small"
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
    password = "Roboshop@1"
  }
  user = {
    name = "user"
    type = "t3.micro"
  }
  shipping = {
    name = "shipping"
    type = "t3.medium"
    password = "Roboshop@1"
  }
}
db_servers = {
  mangodb = {
    name = "mongodb"
    type = "t3.micro"
    password = "Roboshop@1"
  }

  reddis = {
    name = "redis"
    type = "t3.micro"
    password = "Roboshop@1"
  }

  rabbitmq = {
    name = "rabitmq"
    type = "t3.micro"
    password = "Roboshop@1"
  }

  mysql = {
    name = "mysql"
    type = "t3.micro"
    password = "Roboshop@1"
  }
}
