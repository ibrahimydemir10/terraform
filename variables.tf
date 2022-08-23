variable "number_of_subnets" {
    type = number
    description = "this defines the number of subnets"
    default = 2
    validation {
      condition = var.number_of_subnets < 14
      error_message = "The number of subnets must be less than 5"
    }
}

variable "number_of_linux_machines" {
  type = number
  description = " this defines the number of linux virtual machines"
  default = 2

}
variable "number_of_windows_machines" {
  type = number
  description = " this defines the number of linux virtual machines"
  default = 2

}