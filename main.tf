module "sns" {
  source         = "./modules/sns"
  sns_topic_name = "iot_notifications_topic"
  sqs_queue_arn  = module.sqs.sqs_queue_arn
}

module "sqs" {
  source        = "./modules/sqs"
  queue_name    = "iot_notifications_queue"
  sns_topic_arn = module.sns.sns_topic_arn
}

module "lambda" {
  source                    = "./modules/lambda"
  lambda_function_name      = "iot_notifications_lambda"
  lambda_handler            = "app.handler"
  lambda_runtime            = "python3.8"
  lambda_timeout            = 10
  lambda_memory_size        = 128
  lambda_execution_role_name = "my_lambda_execution_role"
  lambda_zip_file           = "./lambda_src/lambda_function.zip" 
  sqs_queue_arn = module.sqs.sqs_queue_arn
}
variable "queue_name" {
  description = "Nombre de la cola SQS"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN del tema SNS"
  type        = string
}

variable "sqs_queue_arn" {
  description = "ARN de la cola SQS"
  type        = string
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "lambda_handler" {
  description = "Manejador de la función Lambda"
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime de la función Lambda"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout de la función Lambda"
  type        = number
}

variable "lambda_memory_size" {
  description = "Tamaño de memoria de la función Lambda en MB"
  type        = number
}

variable "lambda_execution_role_name" {
  description = "Nombre del rol de ejecución de la función Lambda"
  type        = string
}

variable "lambda_zip_file" {
  description = "Ruta al archivo .zip de la función Lambda"
  type        = string
}
