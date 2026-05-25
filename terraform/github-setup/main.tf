terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "monorepo" {
  name        = "king-kong-barbershop"
  description = "Monorepo Java Spring + NestJS + Proxmox IaC"
  visibility  = "public"
  auto_init   = true
}

resource "github_branch" "dev" {
  repository    = github_repository.monorepo.name
  branch        = "dev"
  source_branch = "main"
}

resource "github_branch" "staging" {
  repository    = github_repository.monorepo.name
  branch        = "staging"
  source_branch = "main"
  depends_on    = [github_branch.dev]
}

# branch protection rules

resource "github_branch_protection" "main_rules" {
  repository_id = github_repository.monorepo.node_id
  pattern       = "main"

  enforce_admins = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }

  required_status_checks {
    strict   = true
    contexts = ["ci/github-actions"]
  }

  allows_deletions    = false
  allows_force_pushes = false
}

resource "github_branch_protection" "staging_rules" {
  repository_id  = github_repository.monorepo.node_id
  pattern        = "staging"
  enforce_admins = false

  required_pull_request_reviews {
    required_approving_review_count = 1
  }

  required_status_checks {
    strict   = true
    contexts = ["ci/github-actions"]
  }

  allows_force_pushes = false
}

resource "github_branch_protection" "dev_rules" {
  repository_id  = github_repository.monorepo.node_id
  pattern        = "dev"
  enforce_admins = false

  required_pull_request_reviews {
    required_approving_review_count = 1
  }

  required_status_checks {
    strict   = true
    contexts = ["ci/github-actions"]
  }

  allows_force_pushes = false
}
