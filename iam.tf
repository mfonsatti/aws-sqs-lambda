data "aws_iam_policy_document" "sqs_reader_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.terraform_queue.arn
    ]
  }
}

resource "aws_iam_role" "sqs_reader_role" {
  assume_role_policy = data.aws_iam_policy_document.sqs_reader_role_policy.json
}
