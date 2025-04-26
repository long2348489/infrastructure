variable "cidr_block" {
  description = "The network CIDR block of VPC"
  default     = "10.0.0.0/16"
}

variable "default_tags" {
  default = {
    created_by       = "Tam Tran"
    created_on       = "Random time"
    last_modified_by = "Tam Tran"
    last_modified_on = "Random time"
  }
}
