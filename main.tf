provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "meu_bucket_terraform" {
  bucket = "valdenor-terraform-2026-teste" # Escolha um nome único
}
