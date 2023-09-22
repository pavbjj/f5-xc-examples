terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.26"
    }
  }
}

provider "volterra" {
  timeout      = "90s"
  api_p12_file = "./mycertp12"
  url          = "https://mytenant.console.ves.volterra.io/api"
}
