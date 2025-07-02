resource "aws_ecr_repository" "ecr_backend_repository" {
  name                 = var.ecr_backend_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "ecr_frontend_repository" {
  name                 = var.ecr_frontend_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
