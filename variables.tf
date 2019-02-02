variable "region" {
    default = "eu-central-1"
}
variable "profile" {
    default = "DEV"
}
variable "key_name" {
  default = "gleb-chuev"
}
variable "credentials_file" {
  default = "~/.aws/credentials"
}
variable "ssh_key_private" {
  description = "path to private key"
  default     = "/Users/glebchuev/code/parallels-task1/gleb-chuev.pem"
}