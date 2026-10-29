terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "terraform-web-server"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8082
  }
}

output "container_name" {
  value = docker_container.web.name
}

output "web_url" {
  value = "http://localhost:8082"
}