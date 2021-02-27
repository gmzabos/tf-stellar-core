### Declare variables
variable "default_tags" {
  type = map
  default = {
    Owner       = "<Your account>",
    Contact     = "<Your contact>",
    Environment = "<Your environment>"
    TF-Managed  = "true"
  }
}