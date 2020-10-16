terraform {
  backend "remote" {
    organization = "org-aereal"
    workspaces {
      name = "github-settings"
    }
  }
}

provider "github" {
  token = var.github_token
}
