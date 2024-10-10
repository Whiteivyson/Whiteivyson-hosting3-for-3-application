variable "cidr" {
  type    = list(any)
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "az" {
  type    = list(any)
  default = ["us-west-1c", "us-west-1b"]
}