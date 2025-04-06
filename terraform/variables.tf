variable "gitlab_server" {
  description = "gitlab_server"
  type        = string
}

variable "gitlab_user" {
  description = "gitlab_user"
  type        = string
}

variable "gitlab_token" {
  description = "gitlab_token"
  type        = string
}

variable "db_connection_string" {
  description = "Database connection string"
  type        = string
}

variable "image_name" {
  description = "Naam van de container image"
  type        = string
  default     = "portfolio-flask"
}

variable "aws_region" {
  description = "AWS regio"
  type        = string
  default     = "eu-west-1"
}

variable "docker_image" {
  description = "Docker image URL from GitLab Container Registry"
  type        = string
}