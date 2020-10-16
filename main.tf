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

data "github_repository" "cdk-dynamodb-expression" {
  full_name = "aereal/cdk-dynamodb-expression"
}

data "github_repository" "aws-cdk-apigw-documentation" {
  full_name = "aereal/aws-cdk-apigw-documentation"
}

data "github_repository" "react-type-safe-render" {
  full_name = "aereal/react-type-safe-render"
}

data "github_repository" "eslint-config" {
  full_name = "aereal/eslint-config"
}

data "github_repository" "qron" {
  full_name = "aereal/qron"
}

resource "github_actions_secret" "npm_token" {
  for_each        = toset([
    data.github_repository.cdk-dynamodb-expression.full_name,
    data.github_repository.aws-cdk-apigw-documentation.full_name,
    data.github_repository.react-type-safe-render.full_name,
    data.github_repository.eslint-config.full_name,
    data.github_repository.qron.full_name,
  ])
  repository      = each.value
  secret_name     = "NPM_TOKEN"
  plaintext_value = var.npm_token
}
