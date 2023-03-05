variable "project" {
  description = "プロジェクトID"
  type        = string
}

variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "project_number" {
  description = "プロジェクト番号"
  type        = string
}

variable "compute_name" {
  description = "インスタンス名"
  type        = string
  default     = "vpn-server"
}

variable "region" {
  description = "https://cloud.google.com/about/locations?hl=ja"
  type        = string
  default     = "us-west1"
}

variable "zone" {
  description = "https://cloud.google.com/compute/docs/regions-zones?hl=ja"
  type        = string
  default     = "us-west1-b"
}

variable "account" {
  description = "Google アカウント"
  type        = string
}
