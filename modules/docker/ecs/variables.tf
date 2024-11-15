variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "The name of the ECS task family"
  type        = string
}

variable "container_name" {
  description = "The name of the container within the ECS task"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
}

variable "host_port" {
  description = "The port on the host to map to the container port"
  type        = number
}

variable "memory" {
  description = "The amount of memory (in MiB) to allocate to the task"
  type        = number
}

variable "cpu" {
  description = "The amount of CPU units to allocate to the task"
  type        = number
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "subnets" {
  description = "The IDs of the subnets in which to place the task"
  type        = list(string)
}

variable "security_groups" {
  description = "The security group IDs to associate with the task"
  type        = list(string)
}
