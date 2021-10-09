terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "terraform-example-queue-deadletter"
}

resource "aws_sqs_queue" "terraform_queue" {
  name = "terraform-example-queue"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.terraform_queue_deadletter.arn}"
    maxReceiveCount     = 4
  })
}
