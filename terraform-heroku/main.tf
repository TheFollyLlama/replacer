terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.0"
    }
  }
}

variable "app_name" {
  description = "App name, for naming apps"
}

resource "heroku_app" "default" {
  name   = var.app_name
  region = "eu"
}


# Build code & release to the app
resource "heroku_build" "default" {
  app        = heroku_app.default.name
  buildpacks = ["https://github.com/heroku/heroku-buildpack-ruby"]
  source {
    path = "../ruby"
  #  url  = "https://github.com/TheFollyLlama/replacer/raw/master/ruby.tar.gz"
  }
}

output "default_app_url" {
  value = "https://${heroku_app.default.name}.herokuapp.com"
}
